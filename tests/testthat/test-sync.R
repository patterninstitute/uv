test_that("sync() errors outside a uv project", {

  uv::with_temp_project({

    expect_error(
      sync(quiet = TRUE),
      "uv project"
    )

  })

})

test_that("sync() succeeds when uv.lock is missing", {
  skip_if_not(available())

  uv::with_temp_project({
    uv_init(.verbose = FALSE)
    expect_silent(sync(quiet = TRUE))
    expect_true(dir.exists(".venv"))
  })
})

test_that("sync() synchronises environment when lock exists", {

  skip_if_not(available())

  uv::with_temp_project({

    uv_init(.verbose = FALSE)

    lock(verbose = FALSE)

    expect_silent(
      sync(quiet = TRUE)
    )

    expect_true(dir.exists(".venv"))

  })

})


test_that("sync() is idempotent", {

  skip_if_not(available())

  uv::with_temp_project({

    uv_init(.verbose = FALSE)

    lock(verbose = FALSE)

    sync(quiet = TRUE)
    sync(quiet = TRUE)

    expect_true(dir.exists(".venv"))

  })

})


test_that("sync() works from a subdirectory", {

  skip_if_not(available())

  uv::with_temp_project({

    uv_init(.verbose = FALSE)

    lock(verbose = FALSE)

    dir.create("subdir")

    expect_silent(
      sync(quiet = TRUE)
    )

    expect_true(dir.exists(".venv"))

  })

})
