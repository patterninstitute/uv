test_that("lock_exists returns FALSE when no project exists", {
  skip_if_not(available())

  withr::local_tempdir() |>
    withr::with_dir({
      expect_false(lock_exists())
    })
})

test_that("lock_exists returns FALSE when project exists but no lockfile", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)
    expect_false(lock_exists())
  })
})

test_that("lock_exists returns TRUE after creating lockfile", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)
    lock(verbose = FALSE)
    expect_true(lock_exists())
  })
})

test_that("lock_exists works from subdirectory", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)
    lock(verbose = FALSE)

    # Create subdirectory and test from there
    dir.create("subdir")
    expect_true(lock_exists("subdir"))
  })
})

test_that("lock_path returns correct path", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)
    lock(verbose = FALSE)

    path <- lock_path()
    expect_true(fs::file_exists(path))
    expect_match(path, "uv\\.lock$")
  })
})

test_that("lock_path works from subdirectory", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)
    lock(verbose = FALSE)

    dir.create("subdir")
    path <- lock_path("subdir")
    expect_true(fs::file_exists(path))
    expect_match(path, "uv\\.lock$")
  })
})

test_that("check_lock returns FALSE when no project exists", {
  skip_if_not(available())

  withr::local_tempdir() |>
    withr::with_dir({
      expect_false(check_lock())
    })
})

test_that("check_lock returns FALSE when no lockfile exists", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)
    expect_false(check_lock())
  })
})

test_that("check_lock returns TRUE when lockfile is up-to-date", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)
    lock(verbose = FALSE)
    expect_true(check_lock())
  })
})

test_that("check_lock returns FALSE when lockfile is stale", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)
    lock(verbose = FALSE)
    expect_true(check_lock())

    # Manually modify pyproject.toml to make lockfile stale
    # (add() automatically updates the lockfile, so we edit directly)
    pyproject <- readLines("pyproject.toml")

    # Find and replace the dependencies line, or add one
    if (any(grepl("^dependencies\\s*=", pyproject))) {
      dep_line <- grep("^dependencies\\s*=", pyproject)
      pyproject[dep_line] <- 'dependencies = ["requests>=2.0"]'
    } else {
      pyproject <- c(pyproject, 'dependencies = ["requests>=2.0"]')
    }

    writeLines(pyproject, "pyproject.toml")

    # Now lockfile should be stale
    expect_false(check_lock())

    # Update lockfile
    lock(verbose = FALSE)
    expect_true(check_lock())
  })
})

test_that("check_lock works from subdirectory", {
  skip_if_not(available())

  with_temp_project({
    init(verbose = FALSE)
    lock(verbose = FALSE)

    dir.create("subdir")
    expect_true(check_lock("subdir"))
  })
})
