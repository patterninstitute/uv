# Check if lockfile is up-to-date

Checks whether the `uv.lock` file is consistent with `pyproject.toml`.
This is a non-modifying check that returns `TRUE` or `FALSE`.

## Usage

``` r
check_lock(path = ".")
```

## Arguments

- path:

  Directory inside a uv project.

## Value

`TRUE` if the lockfile exists and is up-to-date with `pyproject.toml`,
`FALSE` otherwise.

## Details

This function runs `uv lock --check` which verifies that:

- A `uv.lock` file exists

- The lockfile is consistent with the current `pyproject.toml`

If either condition is not met, the function returns `FALSE`. Unlike
[`lock()`](https://www.pattern.institute/uv/reference/lock.md), this
function never modifies the lockfile.

## See also

- [`lock()`](https://www.pattern.institute/uv/reference/lock.md) to
  create or update the lockfile

- [`lock_exists()`](https://www.pattern.institute/uv/reference/lock_exists.md)
  to check only for existence

## Examples

``` r
with_temp_project({
  init()

  # No lockfile yet
  check_lock()

  # Create lockfile
  lock()

  # Now it's up-to-date
  check_lock()

  # Add a dependency (lockfile becomes stale)
  add("requests")
  check_lock()

  # Update the lockfile
  lock()
  check_lock()
})
#> 
#> ── Initialising Python project 
#> ✔ Writing README.md (<file:///tmp/Rtmppl72Ac/uv-project-1c8ef63fff8/README.md>)
#> ✔ Writing main.py (<file:///tmp/Rtmppl72Ac/uv-project-1c8ef63fff8/main.py>)
#> ✔ Writing pyproject.toml
#>   (<file:///tmp/Rtmppl72Ac/uv-project-1c8ef63fff8/pyproject.toml>)
#> ✔ Lockfile updated.
#> 
#> ── Adding packages 
#> ℹ Updating pyproject.toml (<file:///tmp/Rtmppl72Ac/uv-project-1c8ef63fff8/pyproject.toml>)
#> ✔ certifi==2026.1.4
#> ✔ charset-normalizer==3.4.4
#> ✔ idna==3.11
#> ✔ requests==2.32.5
#> ✔ urllib3==2.6.3
#> ✔ Lockfile updated.
#> [1] TRUE
```
