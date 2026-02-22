#' Locate the pyproject.toml file for a uv project
#'
#' Returns the path to the `pyproject.toml` file for the uv project containing
#' `path`. Errors if no uv project is found.
#'
#' @param path Directory inside a uv project.
#'
#' @return
#' A character string giving the path to `pyproject.toml`.
#'
#' @export
pyproject_path <- function(path = ".") {
  root <- check_pyproject(path)
  fs::path(root, "pyproject.toml")
}
