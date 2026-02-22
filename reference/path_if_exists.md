# Return a path if it exists

Helper to standardise the common pattern of checking whether a path-like
string is non-empty and returning `NULL` otherwise.

This is particularly useful with functions such as
[`Sys.which()`](https://rdrr.io/r/base/Sys.which.html), environment
variables, or other APIs that return `""` when a path is not found.

## Usage

``` r
path_if_exists(x)
```

## Arguments

- x:

  A character string, typically representing a file path.

## Value

The input path, with names removed, if `x` is a non-empty string;
otherwise `NULL`.

## Examples

``` r
if (FALSE) { # \dontrun{
path_if_exists(Sys.which("ls"))
path_if_exists("")} # }
```
