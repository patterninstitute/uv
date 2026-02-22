# Require a uv project

Errors if the given path is not inside a uv project (both
`pyproject.toml` and `uv.lock` must be present).

## Usage

``` r
check_project(path = ".")
```

## Arguments

- path:

  Directory to check. Defaults to the current working directory.

## Value

Invisibly returns the project root if a uv project is detected.

## Examples

``` r
if (FALSE) check_project() # \dontrun{}
```
