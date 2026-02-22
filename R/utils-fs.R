fs_diff_created <- function(before, after) {
  setdiff(after, before)
}

inform_created_files <- function(files) {
  if (length(files) == 0) {
    return(invisible())
  }

  cli::cli_bullets(stats::setNames(paste0("Writing ", path_link(files)), rep("v", length(files))))
}

#' Filter user-facing created files
#'
#' Remove infrastructure and tooling artefacts from a set of newly created
#' files, keeping only user-facing project files.
#'
#' @param files Character vector of file paths.
#'
#' @return Character vector of filtered file paths.
#'
#' @keywords internal
filter_created_init_files <- function(files) {
  drop <- grepl("^\\.", files)

  keep_explicit <- files %in% c(
    "pyproject.toml",
    "README.md",
    "main.py"
  )

  keep_src <- grepl("^src/.*\\.py$", files)

  files[!drop | keep_explicit | keep_src]
}
