#' Check if lockfile exists
#'
#' Returns `TRUE` if a `uv.lock` file exists in the project.
#'
#' @param path Directory inside a uv project.
#'
#' @return
#' `TRUE` if `uv.lock` exists, `FALSE` otherwise.
#'
#' @examplesIf uv::available()
#' with_temp_project({
#'   init()
#'
#'   # No lockfile yet
#'   lock_exists()
#'
#'   # Create lockfile
#'   lock()
#'
#'   # Now it exists
#'   lock_exists()
#' })
#'
#' @export
lock_exists <- function(path = ".") {
  root <- project_root(path)
  if (is.null(root)) {
    return(FALSE)
  }

  fs::file_exists(fs::path(root, "uv.lock"))
}


#' Get the path to the lockfile
#'
#' Returns the path to the `uv.lock` file for the project.
#'
#' @param path Directory inside a uv project.
#'
#' @return
#' A character string giving the path to `uv.lock`.
#'
#' @export
lock_path <- function(path = ".") {
  lockfile_path(path)
}


#' Check if lockfile is up-to-date
#'
#' Checks whether the `uv.lock` file is consistent with `pyproject.toml`.
#' This is a non-modifying check that returns `TRUE` or `FALSE`.
#'
#' @param path Directory inside a uv project.
#'
#' @return
#' `TRUE` if the lockfile exists and is up-to-date with `pyproject.toml`,
#' `FALSE` otherwise.
#'
#' @details
#' This function runs `uv lock --check` which verifies that:
#' * A `uv.lock` file exists
#' * The lockfile is consistent with the current `pyproject.toml`
#'
#' If either condition is not met, the function returns `FALSE`.
#' Unlike [lock()], this function never modifies the lockfile.
#'
#' @seealso
#' * [lock()] to create or update the lockfile
#' * [lock_exists()] to check only for existence
#'
#' @examplesIf uv::available()
#' with_temp_project({
#'   init()
#'
#'   # No lockfile yet
#'   check_lock()
#'
#'   # Create lockfile
#'   lock()
#'
#'   # Now it's up-to-date
#'   check_lock()
#'
#'   # Add a dependency (lockfile becomes stale)
#'   add("requests")
#'   check_lock()
#'
#'   # Update the lockfile
#'   lock()
#'   check_lock()
#' })
#'
#' @export
check_lock <- function(path = ".") {
  # First check if we're in a project
  root <- project_root(path)
  if (is.null(root)) {
    return(FALSE)
  }

  # Check if lockfile exists
  if (!lock_exists(path)) {
    return(FALSE)
  }

  # Run uv lock --check to see if it's up-to-date
  # This will return non-zero exit code if lockfile is stale
  result <- uv_lock(
    check_up_to_date = TRUE,
    .path = path,
    .dry_run = FALSE
  )

  # Check the exit status - 0 means up-to-date, non-zero means stale
  result$status == 0
}
