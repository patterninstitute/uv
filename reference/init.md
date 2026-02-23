# Initialise a uv project

Create a new Python project using uv.

## Usage

``` r
init(
  name = NULL,
  type = c("app", "package", "library"),
  backend = NULL,
  bare = FALSE,
  vcs = TRUE,
  path = ".",
  verbose = TRUE
)
```

## Arguments

- name:

  Optional project directory name. If `NULL`, initialise the current
  directory.

- type:

  Project type: `"app"`, `"package"`, or `"library"`.

- backend:

  Optional build backend (e.g. `"uv_build"`, `"hatchling"`, `"maturin"`,
  `"scikit-build-core"`).

- bare:

  Logical; create a minimal project structure.

- vcs:

  Logical; initialise version control (git).

- path:

  Directory in which to create the project.

- verbose:

  Whether to print messages.

## Value

Invisibly returns `NULL`. Called for its side effects.

## Examples

``` r
withr::local_tempdir() |>
  withr::with_dir({

    init("myapp")
    fs::dir_ls("myapp")

    init("mylib", type = "library")
    fs::dir_ls("mylib")

    init("pkg", type = "package", backend = "maturin")
    fs::dir_ls("pkg")
  })
#> Error: ! command is not a string (length 1 character)
```
