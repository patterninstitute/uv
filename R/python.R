#' Get Python interpreter used by uv
#'
#' Returns the path to the Python interpreter selected by uv for a project.
#'
#' @param path Directory inside a uv project.
#'
#' @return
#' A character string giving the path to the Python interpreter.
#'
#' @examplesIf uv::available()
#' withr::local_tempdir() |>
#'   withr::with_dir({
#'     init()
#'     python()
#'   })
#'
#' @export
python <- function(path = ".") {
  res <- uv(namespace = "python", verb = "find", .path = path, .echo = FALSE)
  trimws(res$stdout)
}

#' Get Python version used by uv
#'
#' Returns the version of the Python interpreter selected by uv for a project.
#'
#' @param path Directory inside a uv project.
#'
#' @return
#' A character string giving the Python version.
#'
#' @examplesIf uv::available()
#' with_temp_project({
#'     init()
#'     python_version()
#'   })
#'
#' @export
python_version <- function(path = ".") {

  py <- python(path = path)

  res <- processx::run(
    command = py,
    args = c("-c", "import sys; print(sys.version.split()[0])"),
    echo = FALSE
  )

  trimws(res$stdout)
}

