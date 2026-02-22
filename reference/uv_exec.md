# Execute the uv binary

Low-level interface to the `uv` executable.

## Usage

``` r
uv_exec(args, wd = ".", echo = TRUE, error_on_status = FALSE, ...)
```

## Arguments

- args:

  Character vector of command-line arguments passed to `uv`.

- wd:

  Working directory in which to run `uv`.

- echo:

  Logical; whether to stream process output to the console.

- error_on_status:

  Logical; whether to throw an error if `uv` exits with a non-zero
  status.

- ...:

  Additional arguments passed to
  [`processx::run()`](http://processx.r-lib.org/reference/run.md).

## Value

A `processx` result object.

## Details

This function is a thin wrapper around
[`processx::run()`](http://processx.r-lib.org/reference/run.md) that
resolves the location of the `uv` binary and executes it with the
supplied arguments.

It performs **no semantic interpretation** of arguments. All uv grammar,
project logic, and validation must be implemented at higher levels.
