# Lock project dependencies using uv (engine)

Resolves and validates the dependency state of a uv project.

## Usage

``` r
uv_lock(
  check_up_to_date = FALSE,
  check_exists = FALSE,
  upgrade = FALSE,
  upgrade_package = NULL,
  script = NULL,
  .path = ".",
  .dry_run = FALSE
)
```

## Arguments

- check_up_to_date:

  Logical; if `TRUE`, check whether `uv.lock` is consistent with
  `pyproject.toml` without modifying it.

- check_exists:

  Logical; if `TRUE`, assert that a `uv.lock` file exists without
  checking whether it is up-to-date.

- upgrade:

  Logical; if `TRUE`, upgrade all locked packages to the latest versions
  allowed by project constraints.

- upgrade_package:

  Optional package name (or `pkg==version`) to upgrade while leaving all
  other locked versions unchanged.

- script:

  Optional path to a Python script to lock instead of a project.

- .path:

  Directory inside a uv project.

- .dry_run:

  Logical; if `TRUE`, return the command without executing it.

## Value

A `processx` result object, or a `uv_command` if `.dry_run = TRUE`.

## Details

This is a low-level wrapper around `uv lock` that exposes the core
semantic operations needed by the high-level
[`lock()`](https://www.pattern.institute/uv/reference/lock.md) function.
It is intended for internal use and advanced workflows.
