test_that("uvx() runs outside a uv project", {

  skip_if_not(available())

  withr::local_tempdir() |>
    withr::with_dir({
      expect_silent(
        uvx("python", args = c("--version"), quiet = TRUE)
      )
    })

})


test_that("uvx() accepts tool arguments", {

  skip_if_not(available())

  withr::local_tempdir() |>
    withr::with_dir({
      expect_silent(
        uvx("python", args = c("-c", "print('ok')"), quiet = TRUE)
      )
    })

})


test_that("uvx() accepts uv flags", {

  skip_if_not(available())

  withr::local_tempdir() |>
    withr::with_dir({
      expect_silent(
        uvx(
          "python",
          args = c("--version"),
          flags = c("--from", "python"),
          quiet = TRUE
        )
      )
    })

})


test_that("uvx() errors on invalid tool argument", {

  expect_error(
    uvx(character()),
    class = "error"
  )

})


test_that("uvx() is not silent by default", {

  skip_if_not(available())

  withr::local_tempdir() |>
    withr::with_dir({
      expect_failure(
        expect_silent(
          uvx("python", args = "--version")
        )
      )
    })

})
