# Identify the operating system

Returns a short string identifying the operating system in use.

## Usage

``` r
os()
```

## Value

A character string identifying the operating system.

## Details

The value is one of:

- `"win"` for Windows

- `"mac"` for macOS

- `"unix"` for other Unix-like systems

- `"unknown"` if the operating system cannot be classified

This helper provides a stable, simplified OS classification that can be
reused consistently across the package.

## Examples

``` r
if (FALSE) os() # \dontrun{}
```
