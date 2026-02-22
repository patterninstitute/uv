# Find the uv project root

Returns the path to the root directory of the uv project containing the
given path. A uv project is identified by the presence of both
`pyproject.toml` and `uv.lock`, as detected by
[pyprojroot::is_uv_project](https://www.pattern.institute/pyprojroot/reference/is_uv_project.html).

## Usage

``` r
project_root(path = ".")
```

## Arguments

- path:

  Directory or file to start searching from.

## Value

Project root path as a character scalar, or `NULL` if not found.
