#' Uninstall uv
#'
#' Prints the steps required to remove uv from your system. This function does
#' not modify your system --- removal is left to the user to perform manually,
#' since it involves deleting binaries and optionally clearing stored data.
#'
#' @return Invisibly returns `NULL`. Called for its side effects.
#'
#' @seealso [install_uv()]
#'
#' @examples
#' \dontrun{uninstall_uv()}
#'
#' @export
uninstall_uv <- function() {
  if (!available()) {
    cli::cli_inform(c("i" = "uv does not appear to be installed."))
    return(invisible(NULL))
  }

  bin <- uv_path()

  if (is_win()) {
    cli::cli_inform(c(
      "To uninstall uv on Windows, run the following in PowerShell:",
      " " = "",
      " " = "  Remove-Item {.path {bin}}",
      " " = "  Remove-Item {.path {sub('uv.exe', 'uvx.exe', bin)}}",
      " " = "",
      "i" = "To also remove stored data (cache, Python installs, tools):",
      " " = "",
      " " = "  uv cache clean",
      " " = "  Remove-Item -Recurse (uv python dir)",
      " " = "  Remove-Item -Recurse (uv tool dir)"
    ))
  } else {
    cli::cli_inform(c(
      "To uninstall uv, run the following in your terminal:",
      " " = "",
      " " = "  rm {.path {bin}}",
      " " = "  rm {.path {sub('/uv$', '/uvx', bin)}}",
      " " = "",
      "i" = "To also remove stored data (cache, Python installs, tools):",
      " " = "",
      " " = "  uv cache clean",
      " " = "  rm -r \"$(uv python dir)\"",
      " " = "  rm -r \"$(uv tool dir)\""
    ))
  }

  invisible(NULL)
}
