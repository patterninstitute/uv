# Check if lockfile exists

Returns `TRUE` if a `uv.lock` file exists in the project.

## Usage

``` r
lock_exists(path = ".")
```

## Arguments

- path:

  Directory inside a uv project.

## Value

`TRUE` if `uv.lock` exists, `FALSE` otherwise.

## Examples

``` r
with_temp_project({
  init()

  # No lockfile yet
  lock_exists()

  # Create lockfile
  lock()

  # Now it exists
  lock_exists()
})
#> 
#> ── Initialising Python project 
#> ✔ Writing README.md (<file:///tmp/Rtmppl72Ac/uv-project-1c8efc26eec/README.md>)
#> ✔ Writing main.py (<file:///tmp/Rtmppl72Ac/uv-project-1c8efc26eec/main.py>)
#> ✔ Writing pyproject.toml
#>   (<file:///tmp/Rtmppl72Ac/uv-project-1c8efc26eec/pyproject.toml>)
#> ✔ Lockfile updated.
#> /tmp/Rtmppl72Ac/uv-project-1c8efc26eec/uv.lock 
#>                                           TRUE 
```
