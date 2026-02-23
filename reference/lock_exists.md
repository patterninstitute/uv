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
#> Error: ! command is not a string (length 1 character)
```
