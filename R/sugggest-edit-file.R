#' Suggest editing a file
#'
#' Prints a clickable hint to edit a file if running interactively.
#'
#' @param path Path to a file.
#'
#' @keywords internal
suggest_edit_file <- function(path) {
  if (interactive() && fs::file_exists(path)) {
    cli::cli_alert_info("Edit {.file {path}}")
  }

  invisible()
}
