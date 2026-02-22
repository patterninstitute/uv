#' Find the uv project root
#'
#' Returns the path to the root directory of the uv project containing the
#' given path. A uv project is identified by the presence of both
#' `pyproject.toml` and `uv.lock`, as detected by
#' [pyprojroot::is_uv_project].
#'
#' @param path Directory or file to start searching from.
#'
#' @return Project root path as a character scalar, or `NULL` if not found.
#'
#' @export
project_root <- function(path = ".") {
  tryCatch(
    pyprojroot::find_python_root(pyprojroot::is_uv_project, path = path),
    error = function(e) NULL
  )
}

#' Find a Python project root by pyproject.toml alone
#'
#' Like [project_root()] but requires only `pyproject.toml`, not `uv.lock`.
#' Used internally for commands that can run before a lockfile has been
#' created (e.g. `add`, `pip install`, `venv`).
#'
#' @param path Directory or file to start searching from.
#'
#' @return Project root path as a character scalar, or `NULL` if not found.
#'
#' @keywords internal
pyproject_root <- function(path = ".") {
  tryCatch(
    pyprojroot::find_python_root(pyprojroot::is_pyproject, path = path),
    error = function(e) NULL
  )
}

#' Check whether a uv project is present
#'
#' Returns `TRUE` if a uv project can be detected starting from the given
#' directory. A uv project is defined by the presence of both
#' `pyproject.toml` and `uv.lock`.
#'
#' @param path Directory to start searching from. Defaults to the current
#'   working directory.
#'
#' @return `TRUE` if a uv project is detected, `FALSE` otherwise.
#'
#' @examples
#' \dontrun{uses_project()}
#'
#' @export
uses_project <- function(path = ".") {
  !is.null(project_root(path))
}

#' Require a uv project
#'
#' Errors if the given path is not inside a uv project (both `pyproject.toml`
#' and `uv.lock` must be present).
#'
#' @param path Directory to check. Defaults to the current working directory.
#'
#' @return Invisibly returns the project root if a uv project is detected.
#'
#' @examples
#' \dontrun{check_project()}
#'
#' @export
check_project <- function(path = ".") {
  root <- project_root(path)
  if (!is.null(root)) return(invisible(root))

  cli::cli_abort(c(
    "This directory does not appear to be inside a uv project.",
    "i" = "A uv project requires both {.file pyproject.toml} and {.file uv.lock}."
  ))
}

#' Require a pyproject.toml to be present
#'
#' Errors if `pyproject.toml` cannot be found walking up from `path`. Used by
#' commands that can run before `uv.lock` has been created.
#'
#' @param path Directory to check.
#'
#' @return Invisibly returns the root containing `pyproject.toml`.
#'
#' @keywords internal
check_pyproject <- function(path = ".") {
  root <- pyproject_root(path)
  if (!is.null(root)) return(invisible(root))

  cli::cli_abort(c(
    "This directory does not appear to be inside a uv project.",
    "i" = "No {.file pyproject.toml} found in {.path {fs::path_abs(path)}} or any parent directory."
  ))
}

#' Run code with the working directory set to the uv project root
#'
#' Evaluates code with the working directory temporarily set to the root of the
#' uv project containing the given path.
#'
#' @param path Directory used to locate the uv project.
#' @param code Code to evaluate with the working directory set to the project
#'   root.
#'
#' @return Returns the result of evaluating `code`.
#'
#' @examples
#' \dontrun{
#' with_project_root({
#'   uv("lock")
#' })
#' }
#'
#' @export
with_project_root <- function(path = ".", code) {
  root <- check_project(path)
  withr::with_dir(root, force(code))
}

#' Run code inside a temporary uv project workspace
#'
#' Creates a temporary directory, sets it as the working directory and temporary
#' directory, evaluates code, then deletes the directory.
#'
#' @param code Code to evaluate inside the temporary project workspace.
#'
#' @return Returns the result of evaluating `code`.
#'
#' @examples
#' with_temp_project({
#'   cat("Working in:", getwd(), "\n")
#' })
#'
#' @export
with_temp_project <- function(code) {
  tmp <- tempfile("uv-project-")
  dir.create(tmp, recursive = TRUE)

  old_wd  <- getwd()
  old_tmp <- Sys.getenv("TMPDIR", unset = NA_character_)

  on.exit({
    setwd(old_wd)
    if (is.na(old_tmp)) {
      Sys.unsetenv("TMPDIR")
    } else {
      Sys.setenv(TMPDIR = old_tmp)
    }
    unlink(tmp, recursive = TRUE, force = TRUE)
  }, add = TRUE)

  setwd(tmp)
  Sys.setenv(TMPDIR = tmp)

  force(code)
}
