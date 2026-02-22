# A minimal uv project fixture: pyproject.toml + uv.lock
# Uses real uv commands so these tests require uv to be installed.
make_uv_project <- function() {
  init(verbose = FALSE)
  uv("lock", .require_project = FALSE, .echo = FALSE)
}

# project_root() ---------------------------------------------------------------

test_that("project_root() returns NULL outside a uv project", {
  withr::local_tempdir() |>
    withr::with_dir({
      expect_null(project_root())
    })
})

test_that("project_root() returns NULL when only pyproject.toml exists", {
  withr::local_tempdir() |>
    withr::with_dir({
      file.create("pyproject.toml")
      expect_null(project_root())
    })
})

test_that("project_root() finds root when both pyproject.toml and uv.lock exist", {
  skip_if_not(available(), "uv not installed")

  with_temp_project({
    make_uv_project()

    root <- project_root()
    expect_true(fs::dir_exists(root))
    expect_true(fs::file_exists(fs::path(root, "pyproject.toml")))
    expect_true(fs::file_exists(fs::path(root, "uv.lock")))
  })
})

test_that("project_root() walks up from a subdirectory", {
  skip_if_not(available(), "uv not installed")

  with_temp_project({
    make_uv_project()
    dir.create("a/b/c", recursive = TRUE)

    root_from_top <- project_root()
    root_from_sub <- project_root("a/b/c")

    expect_equal(
      normalizePath(root_from_sub),
      normalizePath(root_from_top)
    )
  })
})

# uses_project() ---------------------------------------------------------------

test_that("uses_project() returns FALSE outside a uv project", {
  withr::local_tempdir() |>
    withr::with_dir({
      expect_false(uses_project())
    })
})

test_that("uses_project() returns FALSE when only pyproject.toml exists", {
  withr::local_tempdir() |>
    withr::with_dir({
      file.create("pyproject.toml")
      expect_false(uses_project())
    })
})

test_that("uses_project() returns TRUE inside a uv project", {
  skip_if_not(available(), "uv not installed")

  with_temp_project({
    make_uv_project()
    expect_true(uses_project())
  })
})

test_that("uses_project() returns TRUE from a subdirectory", {
  skip_if_not(available(), "uv not installed")

  with_temp_project({
    make_uv_project()
    dir.create("subdir")
    expect_true(uses_project("subdir"))
  })
})

# check_project() --------------------------------------------------------------

test_that("check_project() errors outside a uv project", {
  withr::local_tempdir() |>
    withr::with_dir({
      expect_error(check_project(), "uv project")
    })
})

test_that("check_project() error mentions both required files", {
  withr::local_tempdir() |>
    withr::with_dir({
      expect_error(check_project(), "pyproject.toml")
      expect_error(check_project(), "uv.lock")
    })
})

test_that("check_project() returns root invisibly when project exists", {
  skip_if_not(available(), "uv not installed")

  with_temp_project({
    make_uv_project()

    root <- check_project()
    expect_true(fs::dir_exists(root))
    expect_true(fs::file_exists(fs::path(root, "uv.lock")))
  })
})

# with_project_root() ----------------------------------------------------------

test_that("with_project_root() errors outside a uv project", {
  withr::local_tempdir() |>
    withr::with_dir({
      expect_error(with_project_root(".", getwd()), "uv project")
    })
})

test_that("with_project_root() sets wd to project root", {
  skip_if_not(available(), "uv not installed")

  with_temp_project({
    make_uv_project()
    dir.create("subdir")
    project_wd <- getwd()

    wd_inside <- withr::with_dir("subdir",
                                 with_project_root(".", getwd())
    )

    expect_equal(normalizePath(wd_inside), normalizePath(project_wd))
  })
})

test_that("with_project_root() restores wd after evaluation", {
  skip_if_not(available(), "uv not installed")

  with_temp_project({
    make_uv_project()
    dir.create("subdir")

    withr::with_dir("subdir", {
      wd_before <- getwd()
      with_project_root(".", NULL)
      expect_equal(getwd(), wd_before)
    })
  })
})

test_that("with_project_root() returns the value of code", {
  skip_if_not(available(), "uv not installed")

  with_temp_project({
    make_uv_project()
    result <- with_project_root(".", 42L)
    expect_equal(result, 42L)
  })
})
