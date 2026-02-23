# Call uv using structured command semantics

High-level interface to the `uv` command-line tool.

This function provides a structured API over uv's command grammar,
separating uv-level arguments from R-level control parameters.

uv commands follow the general form:

    uv [namespace] verb [arguments] [flags]

This grammar is made explicit via the `namespace`, `verb`, `.args`, and
`.flags` parameters.

R-level control parameters are prefixed with `.` to clearly distinguish
them from arguments passed to uv.

## Usage

``` r
uv(
  verb = "help",
  namespace = NULL,
  .args = character(),
  .flags = character(),
  .path = ".",
  .require_project = FALSE,
  .require_pyproject = FALSE,
  .require_lock = FALSE,
  .echo = TRUE,
  .error_on_status = FALSE,
  .dry_run = FALSE
)
```

## Arguments

- verb:

  A single character string giving the uv subcommand to execute (e.g.
  `"sync"`, `"install"`, `"find"`).

- namespace:

  Optional command namespace (e.g. `"pip"`, `"python"`, `"tool"`). If
  `NULL`, a top-level uv command is invoked.

- .args:

  Character vector of positional arguments passed to uv.

- .flags:

  Character vector of option flags passed to uv (e.g. `"--upgrade"`,
  `"--group", "dev"`).

- .path:

  Directory used to resolve the uv project root.

- .require_project:

  Logical; if `TRUE`, requires both `pyproject.toml` and `uv.lock` to be
  present.

- .require_pyproject:

  Logical; if `TRUE`, requires only `pyproject.toml` to be present. Use
  for commands that can run before a lockfile exists.

- .require_lock:

  Logical; whether the command requires an existing `uv.lock` file.

- .echo:

  Logical; whether to stream uv output to the console.

- .error_on_status:

  Logical; whether to error if uv exits with a non-zero status code.

- .dry_run:

  Logical; if `TRUE`, return the constructed command without executing
  it.

## Value

A `processx` result object, or (if `.dry_run = TRUE`) the constructed
command as a character vector with class `"uv_command"`.

## Examples

``` r
with_temp_project({

  # 1. Initialise project
  uv("init")
  fs::file_info("pyproject.toml")

  # 2. Declare a dependency
  uv("add", .args = "requests")
  readLines("pyproject.toml")

  # 3. Resolve and lock dependencies
  uv("lock")
  fs::file_info("uv.lock")

  # 4. Materialise environment
  uv("sync", .require_lock = TRUE)
  fs::dir_ls(".venv")

  # 5. Prove the package is importable
  uv("run", .args = c("python", "-c", "import requests; print(requests.__version__)"))
})
#> Error: ! command is not a string (length 1 character)
```
