#' Get the installed uv version string
#'
#' Returns the full version string reported by the `uv` binary, or `NULL` if
#' uv is not found.
#'
#' @return A character scalar such as `"uv 0.6.1 (abc1234 2025-01-01)"`, or
#'   `NULL`.
#'
#' @seealso [uv_version_number()], [available()], [install_uv()]
#'
#' @examples
#' \dontrun{uv_version()}
#'
#' @export
uv_version <- function() {
  if (!available()) return(NULL)
  trimws(uv_exec(args = "--version", echo = FALSE)$stdout)
}

#' Get the installed uv version number
#'
#' Extracts the version number from [uv_version()] and returns it as a
#' [package_version] object, suitable for comparisons such as
#' `uv_version_number() >= "0.5.0"`.
#'
#' @return A [package_version] object, or `NULL` if uv is not found.
#'
#' @seealso [uv_version()], [available()], [install_uv()]
#'
#' @examples
#' \dontrun{
#' uv_version_number()
#' uv_version_number() >= "0.5.0"
#' }
#'
#' @export
uv_version_number <- function() {
  ver <- uv_version()
  if (is.null(ver)) return(NULL)
  # "uv 0.6.1 (abc1234 2025-01-01)" -> "0.6.1"
  m <- regmatches(ver, regexpr("[0-9]+\\.[0-9]+\\.[0-9]+", ver))
  if (!length(m)) return(NULL)
  package_version(m)
}
