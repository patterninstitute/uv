test_that("uv_exec calls processx::run with correct arguments", {

  called <- NULL

  fake_run <- function(command, args, wd, echo, error_on_status, ...) {
    called <<- list(
      command = command,
      args = args,
      wd = wd,
      echo = echo,
      error_on_status = error_on_status
    )
    list(status = 0L)
  }

  run <- function(...) processx::run

  local_mocked_bindings(
    path = function() "/mock/uv",
    run_process = fake_run
  )

  uv_exec(
    args = c("pip", "install", "numpy"),
    wd = "/tmp",
    echo = FALSE,
    error_on_status = TRUE
  )

  expect_identical(called$command, "/mock/uv")
  expect_identical(called$args, c("pip", "install", "numpy"))
  expect_identical(called$wd, "/tmp")
  expect_false(called$echo)
  expect_true(called$error_on_status)
})

