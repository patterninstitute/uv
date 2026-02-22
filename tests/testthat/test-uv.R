test_that("uv version runs successfully", {

  skip_if_not(available())
  out <- uv(namespace = "self", verb = "version", .require_project = FALSE, .echo = FALSE)

  expect_true(is.list(out))
  expect_true(nzchar(trimws(out$stdout)))
})

test_that("uv python find resolves a python interpreter", {

  skip_if_not(available())
  out <- uv(namespace = "python", verb = "find", .require_project = FALSE, .echo = FALSE)

  expect_true(nzchar(trimws(out$stdout)))
})

test_that("uv init creates pyproject.toml", {

  skip_if_not(available())

  withr::local_tempdir() |>
    withr::with_dir({
      uv("init", .require_project = FALSE, .echo = FALSE)
      expect_true(file.exists("pyproject.toml"))
    })
})

test_that("uv lock creates uv.lock in a project", {

  skip_if_not(available())

  withr::local_tempdir() |>
    withr::with_dir({

      uv("init", .require_project = FALSE, .echo = FALSE)
      uv("lock", .echo = FALSE)

      expect_true(file.exists("uv.lock"))
    })
})
