test_that("with_temp_project sets and restores working directory", {

  old <- getwd()

  with_temp_project({
    expect_false(identical(getwd(), old))
  })

  expect_identical(getwd(), old)
})


test_that("with_temp_project provides an isolated writable directory", {

  with_temp_project({

    writeLines("test", "file.txt")
    expect_true(file.exists("file.txt"))
  })
})


test_that("with_temp_project returns evaluated result", {

  out <- with_temp_project({
    1 + 1
  })

  expect_identical(out, 2)
})


