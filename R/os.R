#' Identify the operating system
#'
#' Returns a short string identifying the operating system in use.
#'
#' The value is one of:
#'
#' - `"win"` for Windows
#' - `"mac"` for macOS
#' - `"unix"` for other Unix-like systems
#' - `"unknown"` if the operating system cannot be classified
#'
#' This helper provides a stable, simplified OS classification that can be
#' reused consistently across the package.
#'
#' @return
#' A character string identifying the operating system.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{os()}
#'
os <- function() {
  if (.Platform$OS.type == "windows") {
    "win"
  } else if (Sys.info()[["sysname"]] == "Darwin") {
    "mac"
  } else if (.Platform$OS.type == "unix") {
    "unix"
  } else {
    "unknown"
  }
}

is_win <- function() {
  os() == "win"
}

is_mac <- function() {
  os() == "mac"
}

is_unix <- function() {
  os() == "unix"
}
