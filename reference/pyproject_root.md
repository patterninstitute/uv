# Find a Python project root by pyproject.toml alone

Like
[`project_root()`](https://www.pattern.institute/uv/reference/project_root.md)
but requires only `pyproject.toml`, not `uv.lock`. Used internally for
commands that can run before a lockfile has been created (e.g. `add`,
`pip install`, `venv`).

## Usage

``` r
pyproject_root(path = ".")
```

## Arguments

- path:

  Directory or file to start searching from.

## Value

Project root path as a character scalar, or `NULL` if not found.
