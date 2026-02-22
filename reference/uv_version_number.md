# Get the installed uv version number

Extracts the version number from
[`uv_version()`](https://www.pattern.institute/uv/reference/uv_version.md)
and returns it as a
[package_version](https://rdrr.io/r/base/numeric_version.html) object,
suitable for comparisons such as `uv_version_number() >= "0.5.0"`.

## Usage

``` r
uv_version_number()
```

## Value

A [package_version](https://rdrr.io/r/base/numeric_version.html) object,
or `NULL` if uv is not found.

## See also

[`uv_version()`](https://www.pattern.institute/uv/reference/uv_version.md),
[`available()`](https://www.pattern.institute/uv/reference/available.md),
[`install_uv()`](https://www.pattern.institute/uv/reference/install_uv.md)

## Examples

``` r
if (FALSE) { # \dontrun{
uv_version_number()
uv_version_number() >= "0.5.0"
} # }
```
