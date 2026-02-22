# Create a clickable link to a path

Formats a clickable hyperlink to a file or directory for cli output. By
default, only the basename is shown while linking to the full path.

## Usage

``` r
path_link(path, basename = TRUE)
```

## Arguments

- path:

  Path to a file(s) or directory/ies.

- basename:

  Logical; if `TRUE`, display only the file or directory name. If
  `FALSE`, display the full path.

## Value

A string containing a cli hyperlink specification.

## Details

This is intended for user-facing messages (e.g. "Edit pyproject.toml"),
not for infrastructure-level file references (use `{.file}` for that).
