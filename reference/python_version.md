# Get Python version used by uv

Returns the version of the Python interpreter selected by uv for a
project.

## Usage

``` r
python_version(path = ".")
```

## Arguments

- path:

  Directory inside a uv project.

## Value

A character string giving the Python version.

## Examples

``` r
with_temp_project({
    init()
    python_version()
  })
#> Error: ! command is not a string (length 1 character)
```
