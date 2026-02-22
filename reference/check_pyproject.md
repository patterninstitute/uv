# Require a pyproject.toml to be present

Errors if `pyproject.toml` cannot be found walking up from `path`. Used
by commands that can run before `uv.lock` has been created.

## Usage

``` r
check_pyproject(path = ".")
```

## Arguments

- path:

  Directory to check.

## Value

Invisibly returns the root containing `pyproject.toml`.
