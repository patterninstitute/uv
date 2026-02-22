test_that("pyproject_path returns correct path", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)

    path <- pyproject_path()
    expect_true(fs::file_exists(path))
    expect_match(path, "pyproject\\.toml$")
  })
})

test_that("pyproject_path works from subdirectory", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)

    dir.create("subdir")
    path <- pyproject_path("subdir")

    expect_true(fs::file_exists(path))
    expect_match(path, "pyproject\\.toml$")
  })
})

test_that("pyproject_path errors when no project exists", {
  withr::local_tempdir() |>
    withr::with_dir({
      expect_error(
        pyproject_path(),
        "not.*inside a uv project"
      )
    })
})

test_that("pyproject_path returns absolute path", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)

    path <- pyproject_path()
    expect_true(fs::is_absolute_path(path))
  })
})
