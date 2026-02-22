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
#> 
#> ── Initialising Python project 
#> ✔ Writing README.md
#>   (<file:///tmp/Rtmppl72Ac/uv-project-1c8e2496778c/README.md>)
#> ✔ Writing main.py (<file:///tmp/Rtmppl72Ac/uv-project-1c8e2496778c/main.py>)
#> ✔ Writing pyproject.toml
#>   (<file:///tmp/Rtmppl72Ac/uv-project-1c8e2496778c/pyproject.toml>)
#> [1] "3.12.3"
```
