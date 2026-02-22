test_that("has_venv returns FALSE when no project exists", {
  withr::local_tempdir() |>
    withr::with_dir({
      expect_false(has_venv())
    })
})


test_that("has_venv returns FALSE when project exists but no venv", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)
    expect_false(has_venv())
  })
})


test_that("has_venv returns TRUE after creating venv", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)
    venv(quiet = TRUE)
    expect_true(has_venv())
  })
})


test_that("has_venv works from subdirectory", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)
    venv(quiet = TRUE)

    dir.create("subdir")
    expect_true(has_venv("subdir"))
  })
})


test_that("has_venv detects manually created .venv", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)

    dir.create(".venv")
    expect_true(has_venv())
  })
})


test_that("venv() errors outside a uv project", {
  uv::with_temp_project({
    expect_error(
      venv(quiet = TRUE),
      "uv project"
    )
  })
})


test_that("venv() creates .venv inside a uv project", {
  uv::with_temp_project({
    uv_init(.verbose = FALSE)
    venv(quiet = TRUE)
    expect_true(dir.exists(".venv"))
  })
})


test_that("venv() is idempotent", {
  uv::with_temp_project({
    uv_init(.verbose = FALSE)
    venv(quiet = TRUE)
    venv(quiet = TRUE)
    expect_true(dir.exists(".venv"))
  })
})


test_that("venv() runs quietly when quiet = TRUE", {
  uv::with_temp_project({
    uv_init(.verbose = FALSE)
    expect_silent(venv(quiet = TRUE))
    expect_true(dir.exists(".venv"))
  })
})
