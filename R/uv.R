run_process <- function(...) {
  processx::run(...)
}

#' Execute the uv binary
#'
#' Low-level interface to the `uv` executable.
#'
#' This function is a thin wrapper around [processx::run()] that resolves the
#' location of the `uv` binary and executes it with the supplied arguments.
#'
#' It performs **no semantic interpretation** of arguments. All uv grammar,
#' project logic, and validation must be implemented at higher levels.
#'
#' @param args Character vector of command-line arguments passed to `uv`.
#' @param wd Working directory in which to run `uv`.
#' @param echo Logical; whether to stream process output to the console.
#' @param error_on_status Logical; whether to throw an error if `uv` exits
#'   with a non-zero status.
#' @param ... Additional arguments passed to [processx::run()].
#'
#' @return
#' A `processx` result object.
#'
#' @keywords internal
uv_exec <- function(args,
                    wd = ".",
                    echo = TRUE,
                    error_on_status = FALSE,
                    ...) {

  check_available()

  run_process(
    command = path(),
    args = args,
    wd = wd,
    echo = echo,
    error_on_status = error_on_status,
    env = c("current", NO_COLOR = "1"),
    ...
  )
}

#' Call uv using structured command semantics
#'
#' @description
#'
#' High-level interface to the `uv` command-line tool.
#'
#' This function provides a structured API over uv's command grammar, separating
#' uv-level arguments from R-level control parameters.
#'
#' uv commands follow the general form:
#'
#' ```
#' uv [namespace] verb [arguments] [flags]
#' ```
#'
#' This grammar is made explicit via the `namespace`, `verb`, `.args`, and
#' `.flags` parameters.
#'
#' R-level control parameters are prefixed with `.` to clearly distinguish them
#' from arguments passed to uv.
#'
#' @param verb A single character string giving the uv subcommand to execute
#'   (e.g. `"sync"`, `"install"`, `"find"`).
#' @param namespace Optional command namespace (e.g. `"pip"`, `"python"`,
#'   `"tool"`). If `NULL`, a top-level uv command is invoked.
#' @param .args Character vector of positional arguments passed to uv.
#' @param .flags Character vector of option flags passed to uv
#'   (e.g. `"--upgrade"`, `"--group", "dev"`).
#' @param .path Directory used to resolve the uv project root.
#' @param .require_project Logical; if `TRUE`, requires both `pyproject.toml`
#'   and `uv.lock` to be present.
#' @param .require_pyproject Logical; if `TRUE`, requires only `pyproject.toml`
#'   to be present. Use for commands that can run before a lockfile exists.
#' @param .require_lock Logical; whether the command requires an existing
#'   `uv.lock` file.
#' @param .echo Logical; whether to stream uv output to the console.
#' @param .error_on_status Logical; whether to error if uv exits with a non-zero
#'   status code.
#' @param .dry_run Logical; if `TRUE`, return the constructed command without
#'   executing it.
#'
#' @return
#' A `processx` result object, or (if `.dry_run = TRUE`) the constructed command
#' as a character vector with class `"uv_command"`.
#'
#' @examplesIf uv::available()
#' with_temp_project({
#'
#'   # 1. Initialise project
#'   uv("init")
#'   fs::file_info("pyproject.toml")
#'
#'   # 2. Declare a dependency
#'   uv("add", .args = "requests")
#'   readLines("pyproject.toml")
#'
#'   # 3. Resolve and lock dependencies
#'   uv("lock")
#'   fs::file_info("uv.lock")
#'
#'   # 4. Materialise environment
#'   uv("sync", .require_lock = TRUE)
#'   fs::dir_ls(".venv")
#'
#'   # 5. Prove the package is importable
#'   uv("run", .args = c("python", "-c", "import requests; print(requests.__version__)"))
#' })
#'
#' @export
uv <- function(verb = "help",
               namespace = NULL,
               .args = character(),
               .flags = character(),
               .path = ".",
               .require_project = FALSE,
               .require_pyproject = FALSE,
               .require_lock = FALSE,
               .echo = TRUE,
               .error_on_status = FALSE,
               .dry_run = FALSE) {
  check_available()

  stopifnot(is.character(verb), length(verb) == 1L)

  if (!is.null(namespace)) {
    stopifnot(is.character(namespace), length(namespace) == 1L)
    cmd <- c(namespace, verb)
  } else {
    cmd <- c(verb)
  }

  cmd <- c(cmd, .args, .flags)

  if (.dry_run) {
    uv_command <- new_uv_command(cmd)
    return(uv_command)
  }

  root <- if (.require_project) {
    check_project(.path)
  } else if (.require_pyproject) {
    check_pyproject(.path)
  } else {
    fs::path_abs(.path)
  }

  if (.require_lock) {
    check_lock(root)
  }

  withr::local_dir(root)

  res <- uv_exec(
    args            = cmd,
    echo            = .echo,
    error_on_status = .error_on_status
  )

  invisible(res)
}

#' Run a Python tool in an isolated environment using uvx
#'
#' Runs a command-line tool provided by a Python package in an ephemeral,
#' isolated environment.
#'
#' This is a thin wrapper around `uv tool run` (i.e. `uvx`).
#'
#' @param tool A single character string. The tool (package) to run
#'   (e.g. `"ruff"`, `"black"`, `"pycowsay"`).
#' @param args Character vector of arguments passed to the tool.
#' @param flags Character vector of uv flags passed to `uv tool run`
#'   (e.g. `"--from", "ruff==0.6.2"`).
#' @param quiet Logical; whether to suppress uv output.
#'
#' @return
#' A `processx` result object, returned invisibly.
#'
#' @examplesIf uv::available()
#' uvx("ruff", args = c("--version"), quiet = TRUE)
#'
#' @export
uvx <- function(tool,
                args = character(),
                flags = character(),
                quiet = FALSE) {
  stopifnot(
    is.character(tool), length(tool) == 1L,
    is.character(args),
    is.character(flags)
  )

  uv(
    namespace = "tool",
    verb = "run",
    .args = c(tool, args),
    .flags = flags,
    .require_project = FALSE,
    .echo = !quiet
  )

  invisible(NULL)
}
