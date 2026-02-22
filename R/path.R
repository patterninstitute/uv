#' Return a path if it exists
#'
#' @description
#'
#' Helper to standardise the common pattern of checking whether a path-like
#' string is non-empty and returning `NULL` otherwise.
#'
#' This is particularly useful with functions such as [Sys.which()], environment
#' variables, or other APIs that return `""` when a path is not found.
#'
#' @param x A character string, typically representing a file path.
#'
#' @return
#' The input path, with names removed, if `x` is a non-empty string;
#' otherwise `NULL`.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' path_if_exists(Sys.which("ls"))
#' path_if_exists("")}
#'
path_if_exists <- function(x) {
  if (nzchar(x)) unname(x) else NULL
}
