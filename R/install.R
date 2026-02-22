#' Install the uv Python package manager
#'
#' Downloads and runs the official uv installer for the current platform.
#' On Unix and macOS the installer script is fetched from
#' `https://astral.sh/uv/install.sh` and piped to `sh`. On Windows it is
#' fetched from `https://astral.sh/uv/install.ps1` and executed with
#' `powershell`.
#'
#' The installer places the `uv` binary in `~/.local/bin` (Unix/macOS) or
#' `%USERPROFILE%\.local\bin` (Windows) and does not require administrator
#' privileges or any system package manager.
#'
#' @param version Character scalar. A specific uv release to install, e.g.
#'   `"0.6.1"`. When `NULL` (the default) the latest release is installed.
#' @param quiet Logical. Suppress installer output. Default `FALSE`.
#'
#' @return Invisibly returns the path to the installed `uv` binary.
#'
#' @seealso [available()], [uv_version()]
#'
#' @examples
#' \dontrun{
#' install_uv()
#' install_uv(version = "0.6.1")
#' }
#'
#' @export
install_uv <- function(version = NULL, quiet = FALSE) {
  if (!is.null(version)) {
    stopifnot(is.character(version), length(version) == 1L, nzchar(version))
  }

  if (is_win()) {
    .install_uv_windows(version = version, quiet = quiet)
  } else {
    .install_uv_unix(version = version, quiet = quiet)
  }

  # Verify the binary is now discoverable
  bin <- path()
  if (is.null(bin)) {
    cli::cli_abort(c(
      "uv was installed but cannot be found.",
      "i" = "You may need to restart your R session or add {.path ~/.local/bin} to PATH."
    ))
  }

  ver <- uv_version()
  cli::cli_inform(c("v" = "{ver} installed at {.path {bin}}"))
  invisible(bin)
}

.install_uv_unix <- function(version, quiet) {
  sh <- Sys.which("sh")
  if (!nzchar(sh)) cli::cli_abort("Cannot find {.code sh} on PATH.")

  curl <- Sys.which("curl")
  if (!nzchar(curl)) {
    cli::cli_abort(c(
      "Cannot find {.code curl} on PATH.",
      "i" = "Install curl or download uv manually from {.url https://github.com/astral-sh/uv/releases}."
    ))
  }

  url <- .installer_url_unix(version)
  cli::cli_inform("Downloading uv installer from {.url {url}}")

  curl_proc <- processx::process$new(
    command = curl,
    args    = c("-LsSf", url),
    stdout  = "|",
    stderr  = if (quiet) NULL else ""
  )

  processx::run(
    command = sh,
    args    = "-s",
    stdin   = curl_proc$get_output_connection(),
    echo    = !quiet,
    error_on_status = FALSE
  )
}

.install_uv_windows <- function(version, quiet) {
  ps <- Sys.which("powershell")
  if (!nzchar(ps)) ps <- Sys.which("pwsh")
  if (!nzchar(ps)) {
    cli::cli_abort(c(
      "Cannot find {.code powershell} or {.code pwsh} on PATH.",
      "i" = "Download uv manually from {.url https://github.com/astral-sh/uv/releases}."
    ))
  }

  url  <- .installer_url_windows(version)
  dest <- tempfile(fileext = ".ps1")
  on.exit(unlink(dest), add = TRUE)

  cli::cli_inform("Downloading uv installer from {.url {url}}")

  # Download to a temp file first. This avoids the irm | iex streaming
  # pattern which proxy/security tools (e.g. Zscaler) intercept, and gives
  # them a chance to scan the file before execution.
  dl <- processx::run(
    command = ps,
    args    = c(
      "-ExecutionPolicy", "ByPass",
      "-c",
      paste0("Invoke-WebRequest -Uri '", url, "' -OutFile '", dest, "'")
    ),
    echo            = FALSE,
    error_on_status = FALSE
  )

  if (dl$status != 0L || !file.exists(dest)) {
    cli::cli_abort(c(
      "Failed to download the uv installer.",
      "i" = "Your network or proxy may be blocking the download.",
      "i" = "Download and run {.url https://github.com/astral-sh/uv/releases} manually."
    ))
  }

  processx::run(
    command = ps,
    args    = c("-ExecutionPolicy", "ByPass", "-File", dest),
    echo    = !quiet,
    error_on_status = FALSE
  )
}

.installer_url_unix <- function(version) {
  if (is.null(version)) {
    "https://astral.sh/uv/install.sh"
  } else {
    paste0("https://astral.sh/uv/", version, "/install.sh")
  }
}

.installer_url_windows <- function(version) {
  if (is.null(version)) {
    "https://astral.sh/uv/install.ps1"
  } else {
    paste0("https://astral.sh/uv/", version, "/install.ps1")
  }
}
