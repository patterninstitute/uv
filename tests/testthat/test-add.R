test_that("uv_add builds correct command in dry run", {

  cmd <- uv_add("requests", .dry_run = TRUE)

  expect_s3_class(cmd, "uv_command")
  expect_identical(
    unclass(cmd),
    c("add", "requests")
  )
})


test_that("uv_add builds correct command with group in dry run", {

  cmd <- uv_add("pytest", group = "dev", .dry_run = TRUE)

  expect_s3_class(cmd, "uv_command")
  expect_identical(
    unclass(cmd),
    c("add", "pytest", "--group", "dev")
  )
})


test_that("add modifies pyproject.toml in a project", {

  skip_if_not(available())

  with_temp_project({

    init(verbose = FALSE)

    add("requests", verbose = FALSE)

    txt <- readLines("pyproject.toml")
    expect_true(any(grepl("requests", txt)))
  })
})


test_that("add errors outside a uv project", {

  expect_error(
    add("requests"),
    "does not appear to be inside a uv project"
  )
})

