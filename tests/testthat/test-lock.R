test_that("lockfile_path resolves uv.lock path", {
  uv::with_temp_project({
    uv_init(.verbose = FALSE)

    path <- lockfile_path()

    expect_equal(basename(path), "uv.lock")
    expect_true(startsWith(normalizePath(path, mustWork = FALSE),
                           normalizePath(getwd(), mustWork = FALSE)))
  })

})


test_that("lock() creates uv.lock in project root", {
  uv::with_temp_project({
    uv_init(.verbose = FALSE)

    expect_false(file.exists(lockfile_path()))

    lock(verbose = FALSE)

    expect_true(file.exists(lockfile_path()))

    expect_equal(
      normalizePath(lockfile_path(), mustWork = FALSE),
      normalizePath(file.path(project_root(), "uv.lock"), mustWork = FALSE)
    )

  })

})


test_that("check_lock() succeeds when uv.lock is missing", {

  uv::with_temp_project({

    uv_init(.verbose = FALSE)

    expect_false(file.exists(lockfile_path()))
    expect_silent(check_lock())

  })
})



test_that("check_lock() succeeds when uv.lock exists", {
  uv::with_temp_project({
    uv_init(.verbose = FALSE)
    lock(verbose = FALSE)

    expect_silent(check_lock())

  })

})
