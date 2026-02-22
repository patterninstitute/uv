#' Install Python packages using uv
#'
#' Installs one or more Python packages into the uv-managed environment for the
#' current uv project.
#'
#' This is a thin wrapper around `uv pip install`. It must be called from within
#' a uv project.
#'
#' @param packages Character vector of package specifications accepted by
#'   `pip install` (e.g. `"requests"`, `"numpy>=2.0"`).
#' @param quiet Logical; whether to suppress uv output.
#'
#' @return
#' A `processx` result object, returned invisibly.
#'
#' @examplesIf uv::available()
#' with_temp_project({
#'   init()
#'   pip_install("requests", quiet = TRUE)
#' })
#'
#' @export
pip_install <- function(packages, quiet = FALSE) {
  stopifnot(
    is.character(packages),
    length(packages) > 0
  )

  uv(
    namespace = "pip",
    verb = "install",
    .args = packages,
    .require_pyproject = TRUE,   # only needs pyproject.toml
    .echo = !quiet
  )
}

