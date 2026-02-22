test_that("uv_version() returns NULL when uv is absent", {
  local_mocked_bindings(available = function() FALSE)
  expect_null(uv_version())
})

test_that("uv_version() returns a string when uv is present", {
  skip_if_not(available(), "uv not installed")
  ver <- uv_version()
  expect_type(ver, "character")
  expect_match(ver, "^uv ")
})

test_that("install_uv() errors with bad version type", {
  expect_error(install_uv(version = 123), "is.character")
})

test_that("install_uv() errors with empty version string", {
  expect_error(install_uv(version = ""), "nzchar")
})

test_that(".installer_url_unix() returns latest URL when version is NULL", {
  expect_equal(
    .installer_url_unix(NULL),
    "https://astral.sh/uv/install.sh"
  )
})

test_that(".installer_url_unix() embeds version when supplied", {
  expect_equal(
    .installer_url_unix("0.6.1"),
    "https://astral.sh/uv/0.6.1/install.sh"
  )
})

test_that(".installer_url_windows() returns latest URL when version is NULL", {
  expect_equal(
    .installer_url_windows(NULL),
    "https://astral.sh/uv/install.ps1"
  )
})

test_that(".installer_url_windows() embeds version when supplied", {
  expect_equal(
    .installer_url_windows("0.6.1"),
    "https://astral.sh/uv/0.6.1/install.ps1"
  )
})

test_that("check_available() aborts with install_uv hint when uv is absent", {
  local_mocked_bindings(available = function() FALSE)
  expect_error(check_available(), "install_uv")
})
