# Get Python interpreter used by uv

Returns the path to the Python interpreter selected by uv for a project.

## Usage

``` r
python(path = ".")
```

## Arguments

- path:

  Directory inside a uv project.

## Value

A character string giving the path to the Python interpreter.

## Examples

``` r
withr::local_tempdir() |>
  withr::with_dir({
    init()
    python()
  })
#> Error: ! command is not a string (length 1 character)
```
