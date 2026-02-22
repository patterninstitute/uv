test_that("path_if_exists returns path for non-empty string", {
  result <- path_if_exists("/usr/bin/ls")
  expect_equal(result, "/usr/bin/ls")
})

test_that("path_if_exists returns NULL for empty string", {
  result <- path_if_exists("")
  expect_null(result)
})

test_that("path_if_exists removes names", {
  named_path <- c(ls = "/usr/bin/ls")
  result <- path_if_exists(named_path)
  expect_equal(result, "/usr/bin/ls")
  expect_null(names(result))
})

test_that("path_if_exists works with Sys.which existing command", {
  # Find a command that should exist on most systems
  ls_path <- Sys.which("ls")
  if (nzchar(ls_path)) {
    result <- path_if_exists(ls_path)
    expect_type(result, "character")
    expect_true(nzchar(result))
  }
})

test_that("path_if_exists returns NULL for Sys.which non-existent command", {
  fake_path <- Sys.which("this_command_definitely_does_not_exist_12345")
  result <- path_if_exists(fake_path)
  expect_null(result)
})
