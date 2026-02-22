#' Create a clickable link to a path
#'
#' Formats a clickable hyperlink to a file or directory for cli output.
#' By default, only the basename is shown while linking to the full path.
#'
#' This is intended for user-facing messages (e.g. "Edit pyproject.toml"),
#' not for infrastructure-level file references (use `{.file}` for that).
#'
#' @param path Path to a file(s) or directory/ies.
#' @param basename Logical; if `TRUE`, display only the file or directory name.
#'   If `FALSE`, display the full path.
#'
#' @return
#' A string containing a cli hyperlink specification.
#'
#' @keywords internal
path_link <- function(path, basename = TRUE) {
  stopifnot(is.character(path))

  target <- fs::path_abs(path)
  label  <- if (basename) fs::path_file(target) else target

  sprintf("{.href [%s](file://%s)}", label, target)
}
