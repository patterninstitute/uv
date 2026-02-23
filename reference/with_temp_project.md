# Run code inside a temporary uv project workspace

Creates a temporary directory, sets it as the working directory and
temporary directory, evaluates code, then deletes the directory.

## Usage

``` r
with_temp_project(code)
```

## Arguments

- code:

  Code to evaluate inside the temporary project workspace.

## Value

Returns the result of evaluating `code`.

## Examples

``` r
with_temp_project({
  cat("Working in:", getwd(), "\n")
})
#> Working in: /tmp/Rtmps0iwey/uv-project-1bc67b21f0a 
```
