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
#> 
#> ── Initialising Python project 
#> ✔ Writing README.md (<file:///tmp/Rtmppl72Ac/file1c8e2cb83b6f/README.md>)
#> ✔ Writing main.py (<file:///tmp/Rtmppl72Ac/file1c8e2cb83b6f/main.py>)
#> ✔ Writing pyproject.toml
#>   (<file:///tmp/Rtmppl72Ac/file1c8e2cb83b6f/pyproject.toml>)
#> [1] "/usr/bin/python3.12"
```
