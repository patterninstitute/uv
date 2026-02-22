lockfile_path <- function(path = ".") {
  root <- pyproject_root(path)
  if (is.null(root)) {
    cli::cli_abort("This directory is not inside a uv project.")
  }

  fs::path(root, "uv.lock")
}


#' Lock project dependencies using uv (engine)
#'
#' Resolves and validates the dependency state of a uv project.
#'
#' This is a low-level wrapper around `uv lock` that exposes the core semantic
#' operations needed by the high-level [lock()] function. It is intended for
#' internal use and advanced workflows.
#'
#' @param check_up_to_date Logical; if `TRUE`, check whether `uv.lock` is
#'   consistent with `pyproject.toml` without modifying it.
#' @param check_exists Logical; if `TRUE`, assert that a `uv.lock` file exists
#'   without checking whether it is up-to-date.
#' @param upgrade Logical; if `TRUE`, upgrade all locked packages to the latest
#'   versions allowed by project constraints.
#' @param upgrade_package Optional package name (or `pkg==version`) to upgrade
#'   while leaving all other locked versions unchanged.
#' @param script Optional path to a Python script to lock instead of a project.
#' @param .path Directory inside a uv project.
#' @param .dry_run Logical; if `TRUE`, return the command without executing it.
#'
#' @return
#' A `processx` result object, or a `uv_command` if `.dry_run = TRUE`.
#'
#' @keywords internal
uv_lock <- function(check_up_to_date = FALSE,
                    check_exists = FALSE,
                    upgrade = FALSE,
                    upgrade_package = NULL,
                    script = NULL,
                    .path = ".",
                    .dry_run = FALSE) {

  stopifnot(
    is.logical(check_up_to_date), length(check_up_to_date) == 1L,
    is.logical(check_exists), length(check_exists) == 1L,
    is.logical(upgrade), length(upgrade) == 1L
  )

  if (!is.null(upgrade_package)) {
    stopifnot(is.character(upgrade_package), length(upgrade_package) == 1L)
  }

  if (!is.null(script)) {
    stopifnot(is.character(script), length(script) == 1L)
  }

  flags <- character()

  if (check_up_to_date) {
    flags <- c(flags, "--check")
  }

  if (check_exists) {
    flags <- c(flags, "--check-exists")
  }

  if (upgrade) {
    flags <- c(flags, "--upgrade")
  }

  if (!is.null(upgrade_package)) {
    flags <- c(flags, "--upgrade-package", upgrade_package)
  }

  if (!is.null(script)) {
    flags <- c(flags, "--script", script)
  }

  uv(
    verb = "lock",
    .flags = flags,
    .path = .path,
    .require_pyproject = TRUE,
    .echo = FALSE,
    .dry_run = .dry_run
  )
}

#' Resolve and validate project dependencies
#'
#' Manages the dependency state of a uv project by creating, validating, or
#' updating the `uv.lock` file.
#'
#' This function models dependency management as a project state operation,
#' rather than a file operation. It can be used to:
#'
#' * create or update the lockfile,
#' * assert that a lockfile exists,
#' * assert that the lockfile is up-to-date,
#' * upgrade locked package versions.
#'
#' @param check_up_to_date Logical; if `TRUE`, check whether the lockfile is
#'   consistent with `pyproject.toml` without modifying it.
#' @param check_exists Logical; if `TRUE`, assert that a lockfile exists.
#' @param upgrade Logical; if `TRUE`, upgrade all locked packages.
#' @param upgrade_package Optional package name (or `pkg==version`) to upgrade.
#' @param path Directory inside a uv project.
#' @param verbose Whether to be chatty.
#'
#' @return
#' Invisibly returns `NULL`. Called for its side effects.
#'
#' @examplesIf uv::available()
#' with_temp_project({
#'
#'   init()
#'
#'   # Create lockfile
#'   lock()
#'
#'   # Assert that a lockfile exists
#'   lock(check_exists = TRUE)
#'
#'   # Assert that it is up-to-date
#'   lock(check_up_to_date = TRUE)
#'
#'   # Upgrade all dependencies
#'   lock(upgrade = TRUE)
#' })
#'
#' @export
lock <- function(check_up_to_date = FALSE,
                 check_exists = FALSE,
                 upgrade = FALSE,
                 upgrade_package = NULL,
                 path = ".",
                 verbose = TRUE) {

  uv_lock(
    check_up_to_date = check_up_to_date,
    check_exists = check_exists,
    upgrade = upgrade,
    upgrade_package = upgrade_package,
    .path = path,
    .dry_run = FALSE
  )

  if (check_exists && verbose) {
    cli::cli_alert_success("Lockfile exists.")
    return(invisible(NULL))
  }

  if (check_up_to_date && verbose) {
    cli::cli_alert_success("Lockfile is up to date.")
    return(invisible(NULL))
  }

  if (!is.null(upgrade_package) && verbose) {
    cli::cli_alert_success(
      "Upgraded {.val {upgrade_package}} and updated lockfile."
    )
  } else if (upgrade && verbose) {
    cli::cli_alert_success("Upgraded all dependencies and updated lockfile.")
  } else {
    if (verbose) cli::cli_alert_success("Lockfile updated.")
  }

  if (interactive()) suggest_edit_file(lockfile_path(path))

  invisible(NULL)
}

