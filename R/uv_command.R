new_uv_command <- function(x) {
  stopifnot(is.character(x))
  structure(x, class = c("uv_command", "character"))
}

#' @export
print.uv_command <- function(x, ...) {
  cat(paste(shQuote(x), collapse = " "), "\n")
  invisible(x)
}

#' @export
format.uv_command <- function(x, ...) {
  paste(x, collapse = " ")
}
