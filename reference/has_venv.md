# Check whether a local uv environment exists

Returns `TRUE` if a local environment appears to exist for the uv
project containing the given path.

## Usage

``` r
has_venv(path = ".")
```

## Arguments

- path:

  Directory to start searching from. Defaults to the current working
  directory.

## Value

`TRUE` if a local environment directory exists, `FALSE` otherwise.

## Details

This function checks for the presence of a `.venv` directory at the
project root. It does not verify that the environment is complete or
usable.

## Examples

``` r
if (FALSE) has_venv() # \dontrun{}
```
