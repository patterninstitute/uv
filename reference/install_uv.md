# Install the uv Python package manager

Downloads and runs the official uv installer for the current platform.
On Unix and macOS the installer script is fetched from
`https://astral.sh/uv/install.sh` and piped to `sh`. On Windows it is
fetched from `https://astral.sh/uv/install.ps1` and executed with
`powershell`.

## Usage

``` r
install_uv(version = NULL, quiet = FALSE)
```

## Arguments

- version:

  Character scalar. A specific uv release to install, e.g. `"0.6.1"`.
  When `NULL` (the default) the latest release is installed.

- quiet:

  Logical. Suppress installer output. Default `FALSE`.

## Value

Invisibly returns the path to the installed `uv` binary.

## Details

The installer places the `uv` binary in `~/.local/bin` (Unix/macOS) or
`%USERPROFILE%\.local\bin` (Windows) and does not require administrator
privileges or any system package manager.

## See also

[`available()`](https://www.pattern.institute/uv/reference/available.md),
[`uv_version()`](https://www.pattern.institute/uv/reference/uv_version.md)

## Examples

``` r
if (FALSE) { # \dontrun{
install_uv()
install_uv(version = "0.6.1")
} # }
```
