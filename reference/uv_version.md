# Get the installed uv version string

Returns the full version string reported by the `uv` binary, or `NULL`
if uv is not found.

## Usage

``` r
uv_version()
```

## Value

A character scalar such as `"uv 0.6.1 (abc1234 2025-01-01)"`, or `NULL`.

## See also

[`uv_version_number()`](https://www.pattern.institute/uv/reference/uv_version_number.md),
[`available()`](https://www.pattern.institute/uv/reference/available.md),
[`install_uv()`](https://www.pattern.institute/uv/reference/install_uv.md)

## Examples

``` r
if (FALSE) uv_version() # \dontrun{}
```
