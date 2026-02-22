# Resolve and validate project dependencies

Manages the dependency state of a uv project by creating, validating, or
updating the `uv.lock` file.

## Usage

``` r
lock(
  check_up_to_date = FALSE,
  check_exists = FALSE,
  upgrade = FALSE,
  upgrade_package = NULL,
  path = ".",
  verbose = TRUE
)
```

## Arguments

- check_up_to_date:

  Logical; if `TRUE`, check whether the lockfile is consistent with
  `pyproject.toml` without modifying it.

- check_exists:

  Logical; if `TRUE`, assert that a lockfile exists.

- upgrade:

  Logical; if `TRUE`, upgrade all locked packages.

- upgrade_package:

  Optional package name (or `pkg==version`) to upgrade.

- path:

  Directory inside a uv project.

- verbose:

  Whether to be chatty.

## Value

Invisibly returns `NULL`. Called for its side effects.

## Details

This function models dependency management as a project state operation,
rather than a file operation. It can be used to:

- create or update the lockfile,

- assert that a lockfile exists,

- assert that the lockfile is up-to-date,

- upgrade locked package versions.

## Examples

``` r
with_temp_project({

  init()

  # Create lockfile
  lock()

  # Assert that a lockfile exists
  lock(check_exists = TRUE)

  # Assert that it is up-to-date
  lock(check_up_to_date = TRUE)

  # Upgrade all dependencies
  lock(upgrade = TRUE)
})
#> 
#> ── Initialising Python project 
#> ✔ Writing README.md (<file:///tmp/Rtmppl72Ac/uv-project-1c8ed87786c/README.md>)
#> ✔ Writing main.py (<file:///tmp/Rtmppl72Ac/uv-project-1c8ed87786c/main.py>)
#> ✔ Writing pyproject.toml
#>   (<file:///tmp/Rtmppl72Ac/uv-project-1c8ed87786c/pyproject.toml>)
#> ✔ Lockfile updated.
#> ✔ Lockfile exists.
#> ✔ Lockfile is up to date.
#> ✔ Upgraded all dependencies and updated lockfile.
```
