#' Locate the uv executable
#'
#' Determines the path to the `uv` executable by checking a fixed and explicit
#' sequence of locations.
#'
#' The lookup is performed in the following order:
#'
#' 1. If the `UV` environment variable is set and non-empty, its value is used
#'    as the path to `uv`.
#' 2. Otherwise, the system `PATH` is searched using `Sys.which("uv")`.
#' 3. If `uv` is still not found, the following OS-specific fallback locations
#'    are checked, in order:
#'
#'    - On Windows:
#'      - `%USERPROFILE%\\.local\\bin\\uv.exe`
#'      - `%LOCALAPPDATA%\\uv\\uv.exe`
#'      - `%USERPROFILE%\\.cargo\\bin\\uv.exe`
#'
#'    - On macOS and other Unix-like systems:
#'      - `~/.local/bin/uv`
#'      - `~/.cargo/bin/uv`
#'
#' If none of these checks succeed, `NULL` is returned.
#'
#' @return
#' A character string giving the path to the `uv` executable, or `NULL`
#' if `uv` cannot be located.
#'
#' @details
#' Setting the `UV` environment variable allows users to explicitly control
#' which `uv` executable is used. This is useful when multiple installations
#' are present or when `uv` is installed in a non-standard location that is not
#' on the system `PATH`.
#'
#' @seealso [available()], [uv_version()], [install_uv()]
#'
#' @examples
#' \dontrun{uv_path()}
#'
#' @export
uv_path <- function() {
  # Explicit override via environment variable
  path <- path_if_exists(Sys.getenv("UV", unset = ""))
  if (!is.null(path)) {
    return(path)
  }

  # PATH lookup
  path <- path_if_exists(Sys.which("uv"))
  if (!is.null(path)) {
    return(path)
  }

  # OS-specific fallback locations
  candidates <- if (is_win()) {
    c(
      file.path(Sys.getenv("USERPROFILE"), ".local", "bin", "uv.exe"),
      file.path(Sys.getenv("LOCALAPPDATA"), "uv", "uv.exe"),
      file.path(Sys.getenv("USERPROFILE"), ".cargo", "bin", "uv.exe")
    )
  } else {
    c(
      "~/.local/bin/uv",
      "~/.cargo/bin/uv"
    )
  }

  candidates <- path.expand(candidates)
  path <- candidates[file.exists(candidates)][1]

  if (length(path)) path else NULL
}

# Internal alias so uv_exec() needs no changes
path <- uv_path

#' Check whether uv is available
#'
#' Tests whether the `uv` executable can be located on the system.
#'
#' @return
#' `TRUE` if `uv` can be found, `FALSE` otherwise.
#'
#' @seealso [uv_path()], [install_uv()]
#'
#' @examples
#' available()
#'
#' @export
available <- function() {
  !is.null(uv_path())
}

#' Require uv to be available
#'
#' Aborts with an informative message if the `uv` executable cannot be found.
#'
#' @return
#' Invisibly returns `NULL` if `uv` is available.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{check_available()}
#'
check_available <- function() {
  if (available()) {
    return(invisible())
  }

  cli::cli_abort(c(
    "Cannot find {.code uv} on your system.",
    "i" = "Run {.run uv::install_uv()} to install it.",
    "i" = "Or see {.url https://docs.astral.sh/uv/getting-started/installation/}."
  ))
}
