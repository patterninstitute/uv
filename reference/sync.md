# Synchronise project dependencies using uv

Synchronises the local uv-managed environment with the dependency set
specified in `uv.lock`.

## Usage

``` r
sync(quiet = FALSE)
```

## Arguments

- quiet:

  Logical; whether to suppress uv output.

## Value

A `processx` result object, returned invisibly.

## Details

This is a thin wrapper around `uv sync`. It must be called from within a
uv project and requires an existing `uv.lock` file.
