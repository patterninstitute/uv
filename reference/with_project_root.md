# Run code with the working directory set to the uv project root

Evaluates code with the working directory temporarily set to the root of
the uv project containing the given path.

## Usage

``` r
with_project_root(path = ".", code)
```

## Arguments

- path:

  Directory used to locate the uv project.

- code:

  Code to evaluate with the working directory set to the project root.

## Value

Returns the result of evaluating `code`.

## Examples

``` r
if (FALSE) { # \dontrun{
with_project_root({
  uv("lock")
})
} # }
```
