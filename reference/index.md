# Package index

## Project lifecycle

Initialise and manage uv projects.

- [`init()`](https://www.pattern.institute/uv/reference/init.md) :
  Initialise a uv project
- [`add()`](https://www.pattern.institute/uv/reference/add.md) : Add
  dependencies to a uv project
- [`lock()`](https://www.pattern.institute/uv/reference/lock.md) :
  Resolve and validate project dependencies
- [`sync()`](https://www.pattern.institute/uv/reference/sync.md) :
  Synchronise project dependencies using uv
- [`venv()`](https://www.pattern.institute/uv/reference/venv.md) :
  Create or update a Python virtual environment

## Tools

Run Python tools in isolated environments.

- [`uv()`](https://www.pattern.institute/uv/reference/uv.md) : Call uv
  using structured command semantics
- [`uvx()`](https://www.pattern.institute/uv/reference/uvx.md) : Run a
  Python tool in an isolated environment using uvx
- [`pip_install()`](https://www.pattern.institute/uv/reference/pip_install.md)
  : Install Python packages using uv

## Python

Inspect the Python interpreter managed by uv.

- [`python()`](https://www.pattern.institute/uv/reference/python.md) :
  Get Python interpreter used by uv
- [`python_version()`](https://www.pattern.institute/uv/reference/python_version.md)
  : Get Python version used by uv

## Project introspection

Query and validate project structure.

- [`uses_project()`](https://www.pattern.institute/uv/reference/uses_project.md)
  : Check whether a uv project is present
- [`has_venv()`](https://www.pattern.institute/uv/reference/has_venv.md)
  : Check whether a local uv environment exists
- [`project_root()`](https://www.pattern.institute/uv/reference/project_root.md)
  : Find the uv project root
- [`pyproject_path()`](https://www.pattern.institute/uv/reference/pyproject_path.md)
  : Locate the pyproject.toml file for a uv project
- [`check_lock()`](https://www.pattern.institute/uv/reference/check_lock.md)
  : Check if lockfile is up-to-date
- [`check_project()`](https://www.pattern.institute/uv/reference/check_project.md)
  : Require a uv project
- [`lock_exists()`](https://www.pattern.institute/uv/reference/lock_exists.md)
  : Check if lockfile exists
- [`lock_path()`](https://www.pattern.institute/uv/reference/lock_path.md)
  : Get the path to the lockfile
- [`uv_path()`](https://www.pattern.institute/uv/reference/uv_path.md) :
  Locate the uv executable
- [`uv_version()`](https://www.pattern.institute/uv/reference/uv_version.md)
  : Get the installed uv version string
- [`uv_version_number()`](https://www.pattern.institute/uv/reference/uv_version_number.md)
  : Get the installed uv version number

## Installation

Install and remove the uv binary.

- [`available()`](https://www.pattern.institute/uv/reference/available.md)
  : Check whether uv is available
- [`install_uv()`](https://www.pattern.institute/uv/reference/install_uv.md)
  : Install the uv Python package manager
- [`uninstall_uv()`](https://www.pattern.institute/uv/reference/uninstall_uv.md)
  : Uninstall uv

## Testing helpers

Utilities for writing tests and examples.

- [`with_temp_project()`](https://www.pattern.institute/uv/reference/with_temp_project.md)
  : Run code inside a temporary uv project workspace
- [`with_project_root()`](https://www.pattern.institute/uv/reference/with_project_root.md)
  : Run code with the working directory set to the uv project root
