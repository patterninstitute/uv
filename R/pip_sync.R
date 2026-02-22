#' Synchronise project dependencies using uv
#'
#' Synchronises the local uv-managed environment with the dependency set
#' specified in `uv.lock`.
#'
#' This is a thin wrapper around `uv sync`. It must be called from within a
#' uv project and requires an existing `uv.lock` file.
#'
#' @param quiet Logical; whether to suppress uv output.
#'
#' @return
#' A `processx` result object, returned invisibly.
#'
#' @export
sync <- function(quiet = FALSE) {
  uv(
    verb = "sync",
    .require_pyproject = TRUE,
    .require_lock = FALSE,
    .echo = !quiet
  )

  invisible(NULL)
}


