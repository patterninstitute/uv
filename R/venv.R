#' Resolve virtual environment path
#'
#' @param path Optional base path. Defaults to project root.
#' @noRd
venv_path <- function(path = NULL) {
  root <- pyproject_root(path)
  fs::path(root, ".venv")
}


#' Check whether a local uv environment exists
#'
#' Returns `TRUE` if a local environment appears to exist for the uv project
#' containing the given path.
#'
#' This function checks for the presence of a `.venv` directory at the project
#' root. It does not verify that the environment is complete or usable.
#'
#' @param path Directory to start searching from. Defaults to the current
#'   working directory.
#'
#' @return
#' `TRUE` if a local environment directory exists, `FALSE` otherwise.
#'
#' @examples
#' \dontrun{has_venv()}
#'
#' @export
has_venv <- function(path = ".") {
  root <- pyproject_root(path)
  if (is.null(root)) {
    return(FALSE)
  }

  dir.exists(file.path(root, ".venv"))
}

#' Create or update a Python virtual environment
#'
#' @param quiet Logical; whether to suppress uv output.
#'
#' @export
venv <- function(quiet = FALSE) {
  uv(
    verb = "venv",
    .require_pyproject = TRUE,
    .echo = !quiet
  )

  invisible(NULL)
}
