uv_init <- function(name = NULL,
                    type = c("app", "package", "library"),
                    backend = NULL,
                    bare = FALSE,
                    vcs = TRUE,
                    .path = ".",
                    .verbose = TRUE,
                    .dry_run = FALSE) {

  type <- match.arg(type)

  root <- project_root(.path)
  if (!is.null(root) && !.dry_run) {
    cli::cli_abort(
      c("A uv project already exists at {.file {root}}.", "i" = "Remove {.file pyproject.toml} if you want to reinitialise the project.")
    )
  }

  flags <- character()

  if (type == "package") flags <- c(flags, "--package")
  if (type == "library") flags <- c(flags, "--lib")
  if (!is.null(backend)) flags <- c(flags, "--build-backend", backend)
  if (bare) flags <- c(flags, "--bare")
  if (!vcs) flags <- c(flags, "--no-vcs")

  args <- if (!is.null(name)) name else character()

  before <- if (.verbose && !.dry_run) {
    list.files(.path, recursive = TRUE, all.files = TRUE)
  }

  withr::local_dir(.path)

  res <-
    uv(
      "init",
      .args = args,
      .flags = flags,
      .require_project = FALSE,
      .echo = FALSE,
      .dry_run = .dry_run
    )

  if (.dry_run) {
    return(res)
  }

  if (.verbose && !.dry_run) {
    cli::cli_h3("Initialising Python project")
    after <- list.files(.path, recursive = TRUE, all.files = TRUE)
    created <- fs_diff_created(before, after)
    created <- filter_created_init_files(created)
    inform_created_files(created)
  }

}

#' Initialise a uv project
#'
#' Create a new Python project using uv.
#'
#' @param name Optional project directory name. If `NULL`, initialise the
#'   current directory.
#' @param type Project type: `"app"`, `"package"`, or `"library"`.
#' @param backend Optional build backend (e.g. `"uv_build"`, `"hatchling"`,
#'   `"maturin"`, `"scikit-build-core"`).
#' @param bare Logical; create a minimal project structure.
#' @param vcs Logical; initialise version control (git).
#' @param path Directory in which to create the project.
#' @param verbose Whether to print messages.
#'
#' @return
#' Invisibly returns `NULL`. Called for its side effects.
#'
#' @examplesIf uv::available()
#' withr::local_tempdir() |>
#'   withr::with_dir({
#'
#'     init("myapp")
#'     fs::dir_ls("myapp")
#'
#'     init("mylib", type = "library")
#'     fs::dir_ls("mylib")
#'
#'     init("pkg", type = "package", backend = "maturin")
#'     fs::dir_ls("pkg")
#'   })
#'
#' @export
init <- function(name = NULL,
                 type = c("app", "package", "library"),
                 backend = NULL,
                 bare = FALSE,
                 vcs = TRUE,
                 path = ".",
                 verbose = TRUE) {
  uv_init(
    name = name,
    type = type,
    backend = backend,
    bare = bare,
    vcs = vcs,
    .path = path,
    .verbose = verbose,
    .dry_run = FALSE
  )
}
