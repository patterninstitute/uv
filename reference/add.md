# Add dependencies to a uv project

Declares one or more dependencies in `pyproject.toml` using `uv add`.
This updates project metadata but does not resolve or install packages.
After adding dependencies, run
[`lock()`](https://www.pattern.institute/uv/reference/lock.md) and then
[`sync()`](https://www.pattern.institute/uv/reference/sync.md).

## Usage

``` r
add(packages, group = NULL, path = ".", verbose = TRUE)
```

## Arguments

- packages:

  Character vector of package specifications to add.

- group:

  Optional dependency group (e.g. `"dev"`).

- path:

  Directory inside a uv project.

- verbose:

  Whether to be chatty.

## Value

Invisibly returns `NULL`. Called for its side effects.

## Examples

``` r
with_temp_project({

  init()

  # Add a runtime dependency
  add("requests")
  readLines("pyproject.toml")

  # Add a development dependency
  add("pytest", group = "dev")
  readLines("pyproject.toml")
})
#> 
#> ── Initialising Python project 
#> ✔ Writing README.md (<file:///tmp/Rtmppl72Ac/uv-project-1c8e5c8ce2c/README.md>)
#> ✔ Writing main.py (<file:///tmp/Rtmppl72Ac/uv-project-1c8e5c8ce2c/main.py>)
#> ✔ Writing pyproject.toml
#>   (<file:///tmp/Rtmppl72Ac/uv-project-1c8e5c8ce2c/pyproject.toml>)
#> 
#> ── Adding packages 
#> ℹ Updating pyproject.toml (<file:///tmp/Rtmppl72Ac/uv-project-1c8e5c8ce2c/pyproject.toml>)
#> ✔ certifi==2026.1.4
#> ✔ charset-normalizer==3.4.4
#> ✔ idna==3.11
#> ✔ requests==2.32.5
#> ✔ urllib3==2.6.3
#> 
#> ── Adding packages 
#> ℹ Updating pyproject.toml (<file:///tmp/Rtmppl72Ac/uv-project-1c8e5c8ce2c/pyproject.toml>)
#> ✔ iniconfig==2.3.0
#> ✔ packaging==26.0
#> ✔ pluggy==1.6.0
#> ✔ pygments==2.19.2
#> ✔ pytest==9.0.2
#>  [1] "[project]"                                  
#>  [2] "name = \"uv-project-1c8e5c8ce2c\""          
#>  [3] "version = \"0.1.0\""                        
#>  [4] "description = \"Add your description here\""
#>  [5] "readme = \"README.md\""                     
#>  [6] "requires-python = \">=3.12\""               
#>  [7] "dependencies = ["                           
#>  [8] "    \"requests>=2.32.5\","                  
#>  [9] "]"                                          
#> [10] ""                                           
#> [11] "[dependency-groups]"                        
#> [12] "dev = ["                                    
#> [13] "    \"pytest>=9.0.2\","                     
#> [14] "]"                                          
```
