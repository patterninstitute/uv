# Check whether a uv project is present

Returns `TRUE` if a uv project can be detected starting from the given
directory. A uv project is defined by the presence of both
`pyproject.toml` and `uv.lock`.

## Usage

``` r
uses_project(path = ".")
```

## Arguments

- path:

  Directory to start searching from. Defaults to the current working
  directory.

## Value

`TRUE` if a uv project is detected, `FALSE` otherwise.

## Examples

``` r
if (FALSE) uses_project() # \dontrun{}
```
