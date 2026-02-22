# Run a Python tool in an isolated environment using uvx

Runs a command-line tool provided by a Python package in an ephemeral,
isolated environment.

## Usage

``` r
uvx(tool, args = character(), flags = character(), quiet = FALSE)
```

## Arguments

- tool:

  A single character string. The tool (package) to run (e.g. `"ruff"`,
  `"black"`, `"pycowsay"`).

- args:

  Character vector of arguments passed to the tool.

- flags:

  Character vector of uv flags passed to `uv tool run` (e.g.
  `"--from", "ruff==0.6.2"`).

- quiet:

  Logical; whether to suppress uv output.

## Value

A `processx` result object, returned invisibly.

## Details

This is a thin wrapper around `uv tool run` (i.e. `uvx`).

## Examples

``` r
uvx("ruff", args = c("--version"), quiet = TRUE)
```
