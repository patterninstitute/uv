uv_add <- function(packages,
                   group = NULL,
                   .path = ".",
                   .dry_run = FALSE) {

  stopifnot(
    is.character(packages),
    length(packages) >= 1L
  )

  if (!is.null(group)) {
    stopifnot(is.character(group), length(group) == 1L)
  }

  flags <- character()
  if (!is.null(group)) {
    flags <- c(flags, "--group", group)
  }

  uv(
    verb = "add",
    .args = packages,
    .flags = flags,
    .path = .path,
    .require_pyproject = TRUE,
    .echo = FALSE,
    .dry_run = .dry_run
  )
}

#' Add dependencies to a uv project
#'
#' Declares one or more dependencies in `pyproject.toml` using `uv add`.
#' This updates project metadata but does not resolve or install packages.
#' After adding dependencies, run `lock()` and then `sync()`.
#'
#' @param packages Character vector of package specifications to add.
#' @param group Optional dependency group (e.g. `"dev"`).
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
#'   # Add a runtime dependency
#'   add("requests")
#'   readLines("pyproject.toml")
#'
#'   # Add a development dependency
#'   add("pytest", group = "dev")
#'   readLines("pyproject.toml")
#' })
#'
#' @export
add <- function(packages,
                group = NULL,
                path = ".",
                verbose = TRUE) {

  res <- uv_add(
    packages = packages,
    group = group,
    .path = path,
    .dry_run = FALSE
  )

  if (verbose) interpret_uv_add_result(res, path = path)

  invisible(NULL)
}


interpret_uv_add_result <- function(res, path) {
  if (is.null(res)) return(invisible())

  if (!nzchar(res$stderr)) {
    cli::cli_alert_success("Dependencies added.")
    return(invisible())
  }

  lines <- strsplit(cli::ansi_strip(res$stderr), "\n")[[1]]
  lines <- trimws(lines)

  # Added packages
  added <- grep("^\\+", lines, value = TRUE)
  if (length(added)) {
    pkgs <- sub("^\\+\\s*", "", added)
    cli::cli_h3("Adding packages")
    cli::cli_alert_info(paste("Updating", path_link(pyproject_path(path))))
    cli::cli_bullets(stats::setNames(pkgs, rep("v", length(pkgs))))
  }

  # Warnings (multi-line)
  warning_idx <- grep("^warning:", lines, ignore.case = TRUE)

  if (length(warning_idx)) {
    i <- warning_idx[1]
    block <- lines[i:length(lines)]

    cont <- which(!nzchar(block) | grepl("^[^[:space:]]", block))
    if (length(cont) > 1) {
      block <- block[seq_len(cont[2] - 1)]
    }

    cli::cli_alert_warning(paste(block, collapse = " "))
  }

  invisible()
}
