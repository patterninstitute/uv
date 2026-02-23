# Add dependencies to a uv project

Declares one or more dependencies in `pyproject.toml` using `uv add`.
This updates project metadata but does not resolve or install packages.
After adding dependencies, run
[`lock()`](https://www.pattern.institute/uv/reference/lock.md) and then
[`sync()`](https://www.pattern.institute/uv/reference/sync.md).

## Usage

``` r
add(packages, group = NULL, path = ".", verbose = TRUE)
```

## Arguments

- packages:

  Character vector of package specifications to add.

- group:

  Optional dependency group (e.g. `"dev"`).

- path:

  Directory inside a uv project.

- verbose:

  Whether to be chatty.

## Value

Invisibly returns `NULL`. Called for its side effects.

## Examples

``` r
with_temp_project({

  init()

  # Add a runtime dependency
  add("requests")
  readLines("pyproject.toml")

  # Add a development dependency
  add("pytest", group = "dev")
  readLines("pyproject.toml")
})
#> Error: ! command is not a string (length 1 character)
```
