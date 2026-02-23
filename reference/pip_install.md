# Install Python packages using uv

Installs one or more Python packages into the uv-managed environment for
the current uv project.

## Usage

``` r
pip_install(packages, quiet = FALSE)
```

## Arguments

- packages:

  Character vector of package specifications accepted by `pip install`
  (e.g. `"requests"`, `"numpy>=2.0"`).

- quiet:

  Logical; whether to suppress uv output.

## Value

A `processx` result object, returned invisibly.

## Details

This is a thin wrapper around `uv pip install`. It must be called from
within a uv project.

## Examples

``` r
with_temp_project({
  init()
  pip_install("requests", quiet = TRUE)
})
#> Error: ! command is not a string (length 1 character)
```
