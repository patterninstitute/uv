test_that("pip_install() errors outside a uv project", {
  uv::with_temp_project({
    expect_error(
      pip_install("requests", quiet = TRUE),
      "uv project"
    )
  })
})

test_that("pip_install() installs a package", {
  skip_if_not(available())

  uv::with_temp_project({
    uv_init(.verbose = FALSE)
    venv(quiet = TRUE)
    expect_silent(pip_install("requests", quiet = TRUE))
  })
})

test_that("pip_install() accepts multiple packages", {
  skip_if_not(available())

  uv::with_temp_project({
    uv_init(.verbose = FALSE)
    venv(quiet = TRUE)
    expect_silent(
      pip_install(c("requests", "certifi"), quiet = TRUE)
    )
  })
})
