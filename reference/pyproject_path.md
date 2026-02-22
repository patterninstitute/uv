# Locate the pyproject.toml file for a uv project

Returns the path to the `pyproject.toml` file for the uv project
containing `path`. Errors if no uv project is found.

## Usage

``` r
pyproject_path(path = ".")
```

## Arguments

- path:

  Directory inside a uv project.

## Value

A character string giving the path to `pyproject.toml`.
