test_that("python returns a valid path", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)

    py_path <- python()

    expect_type(py_path, "character")
    expect_true(nzchar(py_path))
    expect_true(fs::file_exists(py_path))
  })
})

test_that("python works from subdirectory", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)

    dir.create("subdir")
    py_path <- python("subdir")

    expect_type(py_path, "character")
    expect_true(fs::file_exists(py_path))
  })
})

test_that("python_version returns a valid version string", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)

    version <- python_version()

    expect_type(version, "character")
    expect_true(nzchar(version))
    # Should match version pattern like "3.11.5"
    expect_match(version, "^\\d+\\.\\d+")
  })
})

test_that("python_version works from subdirectory", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)

    dir.create("subdir")
    version <- python_version("subdir")

    expect_type(version, "character")
    expect_match(version, "^\\d+\\.\\d+")
  })
})

test_that("python_version is consistent with python", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)

    py_path <- python()
    version <- python_version()

    # Get version directly from the python executable
    direct_version <- processx::run(
      py_path,
      c("-c", "import sys; print(sys.version.split()[0])"),
      echo = FALSE
    )

    expect_equal(version, trimws(direct_version$stdout))
  })
})
