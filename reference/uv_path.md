# Locate the uv executable

Determines the path to the `uv` executable by checking a fixed and
explicit sequence of locations.

## Usage

``` r
uv_path()
```

## Value

A character string giving the path to the `uv` executable, or `NULL` if
`uv` cannot be located.

## Details

The lookup is performed in the following order:

1.  If the `UV` environment variable is set and non-empty, its value is
    used as the path to `uv`.

2.  Otherwise, the system `PATH` is searched using `Sys.which("uv")`.

3.  If `uv` is still not found, the following OS-specific fallback
    locations are checked, in order:

    - On Windows:

      - `%USERPROFILE%\\.local\\bin\\uv.exe`

      - `%LOCALAPPDATA%\\uv\\uv.exe`

      - `%USERPROFILE%\\.cargo\\bin\\uv.exe`

    - On macOS and other Unix-like systems:

      - `~/.local/bin/uv`

      - `~/.cargo/bin/uv`

If none of these checks succeed, `NULL` is returned.

Setting the `UV` environment variable allows users to explicitly control
which `uv` executable is used. This is useful when multiple
installations are present or when `uv` is installed in a non-standard
location that is not on the system `PATH`.

## See also

[`available()`](https://www.pattern.institute/uv/reference/available.md),
[`uv_version()`](https://www.pattern.institute/uv/reference/uv_version.md),
[`install_uv()`](https://www.pattern.institute/uv/reference/install_uv.md)

## Examples

``` r
if (FALSE) uv_path() # \dontrun{}
```
