test_that("os returns valid OS identifier", {
  result <- os()
  expect_type(result, "character")
  expect_true(result %in% c("win", "mac", "unix", "unknown"))
})

test_that("os is consistent with platform", {
  result <- os()

  if (.Platform$OS.type == "windows") {
    expect_equal(result, "win")
  } else if (Sys.info()[["sysname"]] == "Darwin") {
    expect_equal(result, "mac")
  } else if (.Platform$OS.type == "unix") {
    expect_equal(result, "unix")
  }
})

test_that("is_win is consistent with os", {
  expect_equal(is_win(), os() == "win")
})

test_that("is_mac is consistent with os", {
  expect_equal(is_mac(), os() == "mac")
})

test_that("is_unix is consistent with os", {
  expect_equal(is_unix(), os() == "unix")
})

test_that("exactly one OS check returns TRUE", {
  checks <- c(is_win(), is_mac(), is_unix())
  # Either exactly one is TRUE, or os() is "unknown"
  if (os() != "unknown") {
    expect_equal(sum(checks), 1)
  } else {
    expect_equal(sum(checks), 0)
  }
})
