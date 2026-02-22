
<!-- README.md is generated from README.Rmd. Please edit that file -->

# uv <a href="https://www.pattern.institute/uv/"><img src="man/figures/logo.svg" align="right" height="139" alt="uv website" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/patterninstitute/uv/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/patterninstitute/uv/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Call uv from R.

## Installation

``` r
# install.packages("pak")
pak::pak("uv")
```

## Workflow Example

``` r
library(uv)

with_temp_project({
  # Initialise a uv project in the current directory
  uv::init()
  
  # Create a local virtual environment
  uv::venv()
  
  # Add a runtime dependency (declares it in pyproject.toml)
  uv::add("requests")
  
  # Resolve and lock dependencies
  uv::lock()
  
  # Synchronise the environment with the lockfile
  uv::sync()
  
  # Run uv commands directly if needed
  # same as `uv::version()
  uv("--version")
  
  # Run a tool in an ephemeral environment
  uvx("pycowsay", "hello from uv")
})
#> 
#> ── Initialising Python project
#> ✔ Writing main.py (<file:///tmp/RtmpSg4QMs/uv-project-3671034c59d5ec/main.py>)
#> ✔ Writing pyproject.toml
#>   (<file:///tmp/RtmpSg4QMs/uv-project-3671034c59d5ec/pyproject.toml>)
#> ✔ Writing README.md
#>   (<file:///tmp/RtmpSg4QMs/uv-project-3671034c59d5ec/README.md>)
#> Using CPython 3.11.13
#> Creating virtual environment at: .venv
#> Activate with: source .venv/bin/activate
#> 
#> ── Adding packages
#> ℹ Updating pyproject.toml (<file:///tmp/RtmpSg4QMs/uv-project-3671034c59d5ec/pyproject.toml>)
#> ✔ certifi==2026.1.4
#> ✔ charset-normalizer==3.4.4
#> ✔ idna==3.11
#> ✔ requests==2.32.5
#> ✔ urllib3==2.6.3
#> ! warning: Failed to hardlink files; falling back to full copy. This may lead to degraded performance.
#> ✔ Lockfile updated.
#> Resolved 6 packages in 0.33ms
#> Audited 5 packages in 0.00ms
#> uv 0.7.13 (62ed17b23 2025-06-12)
#> 
#>   -------------
#> < hello from uv >
#>   -------------
#>    \   ^__^
#>     \  (oo)\_______
#>        (__)\       )\/\
#>            ||----w |
#>            ||     ||
```
