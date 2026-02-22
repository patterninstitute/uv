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
#> 
#> ── Initialising Python project 
#> ✔ Writing HEAD (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/HEAD>)
#> ✔ Writing config (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/config>)
#> ✔ Writing description
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/description>)
#> ✔ Writing applypatch-msg.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/hooks/applypatch-msg.sample>)
#> ✔ Writing commit-msg.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/hooks/commit-msg.sample>)
#> ✔ Writing fsmonitor-watchman.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/hooks/fsmonitor-watchman.sample>)
#> ✔ Writing post-update.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/hooks/post-update.sample>)
#> ✔ Writing pre-applypatch.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/hooks/pre-applypatch.sample>)
#> ✔ Writing pre-commit.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/hooks/pre-commit.sample>)
#> ✔ Writing pre-merge-commit.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/hooks/pre-merge-commit.sample>)
#> ✔ Writing pre-push.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/hooks/pre-push.sample>)
#> ✔ Writing pre-rebase.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/hooks/pre-rebase.sample>)
#> ✔ Writing pre-receive.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/hooks/pre-receive.sample>)
#> ✔ Writing prepare-commit-msg.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/hooks/prepare-commit-msg.sample>)
#> ✔ Writing push-to-checkout.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/hooks/push-to-checkout.sample>)
#> ✔ Writing sendemail-validate.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/hooks/sendemail-validate.sample>)
#> ✔ Writing update.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/hooks/update.sample>)
#> ✔ Writing exclude
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.git/info/exclude>)
#> ✔ Writing .gitignore
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.gitignore>)
#> ✔ Writing .python-version
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/.python-version>)
#> ✔ Writing README.md (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/README.md>)
#> ✔ Writing main.py (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/main.py>)
#> ✔ Writing pyproject.toml
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/myapp/pyproject.toml>)
#> 
#> ── Initialising Python project 
#> ✔ Writing HEAD (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/HEAD>)
#> ✔ Writing config (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/config>)
#> ✔ Writing description
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/description>)
#> ✔ Writing applypatch-msg.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/hooks/applypatch-msg.sample>)
#> ✔ Writing commit-msg.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/hooks/commit-msg.sample>)
#> ✔ Writing fsmonitor-watchman.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/hooks/fsmonitor-watchman.sample>)
#> ✔ Writing post-update.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/hooks/post-update.sample>)
#> ✔ Writing pre-applypatch.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/hooks/pre-applypatch.sample>)
#> ✔ Writing pre-commit.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/hooks/pre-commit.sample>)
#> ✔ Writing pre-merge-commit.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/hooks/pre-merge-commit.sample>)
#> ✔ Writing pre-push.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/hooks/pre-push.sample>)
#> ✔ Writing pre-rebase.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/hooks/pre-rebase.sample>)
#> ✔ Writing pre-receive.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/hooks/pre-receive.sample>)
#> ✔ Writing prepare-commit-msg.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/hooks/prepare-commit-msg.sample>)
#> ✔ Writing push-to-checkout.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/hooks/push-to-checkout.sample>)
#> ✔ Writing sendemail-validate.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/hooks/sendemail-validate.sample>)
#> ✔ Writing update.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/hooks/update.sample>)
#> ✔ Writing exclude
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.git/info/exclude>)
#> ✔ Writing .gitignore
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.gitignore>)
#> ✔ Writing .python-version
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/.python-version>)
#> ✔ Writing README.md (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/README.md>)
#> ✔ Writing pyproject.toml
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/pyproject.toml>)
#> ✔ Writing __init__.py
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/src/mylib/__init__.py>)
#> ✔ Writing py.typed
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/mylib/src/mylib/py.typed>)
#> 
#> ── Initialising Python project 
#> ✔ Writing HEAD (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/HEAD>)
#> ✔ Writing config (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/config>)
#> ✔ Writing description
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/description>)
#> ✔ Writing applypatch-msg.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/hooks/applypatch-msg.sample>)
#> ✔ Writing commit-msg.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/hooks/commit-msg.sample>)
#> ✔ Writing fsmonitor-watchman.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/hooks/fsmonitor-watchman.sample>)
#> ✔ Writing post-update.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/hooks/post-update.sample>)
#> ✔ Writing pre-applypatch.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/hooks/pre-applypatch.sample>)
#> ✔ Writing pre-commit.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/hooks/pre-commit.sample>)
#> ✔ Writing pre-merge-commit.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/hooks/pre-merge-commit.sample>)
#> ✔ Writing pre-push.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/hooks/pre-push.sample>)
#> ✔ Writing pre-rebase.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/hooks/pre-rebase.sample>)
#> ✔ Writing pre-receive.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/hooks/pre-receive.sample>)
#> ✔ Writing prepare-commit-msg.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/hooks/prepare-commit-msg.sample>)
#> ✔ Writing push-to-checkout.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/hooks/push-to-checkout.sample>)
#> ✔ Writing sendemail-validate.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/hooks/sendemail-validate.sample>)
#> ✔ Writing update.sample
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/hooks/update.sample>)
#> ✔ Writing exclude
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.git/info/exclude>)
#> ✔ Writing .gitignore (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.gitignore>)
#> ✔ Writing .python-version
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/.python-version>)
#> ✔ Writing Cargo.toml (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/Cargo.toml>)
#> ✔ Writing README.md (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/README.md>)
#> ✔ Writing pyproject.toml
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/pyproject.toml>)
#> ✔ Writing lib.rs (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/src/lib.rs>)
#> ✔ Writing __init__.py
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/src/pkg/__init__.py>)
#> ✔ Writing _core.pyi
#>   (<file:///tmp/Rtmppl72Ac/file1c8e84fe91e/pkg/src/pkg/_core.pyi>)
#> pkg/Cargo.toml     pkg/README.md      pkg/pyproject.toml pkg/src            
```
