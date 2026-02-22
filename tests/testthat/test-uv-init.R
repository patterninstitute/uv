test_that("uv_init builds app project command", {

  cmd <- uv_init(
    name = "myapp",
    type = "app",
    .dry_run = TRUE
  )

  expect_s3_class(cmd, "uv_command")

  expect_identical(
    unclass(cmd),
    c("init", "myapp")
  )
})

