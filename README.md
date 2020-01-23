
Sample python project to show how to organize a python project with multi packages

## Features

- multiple packages (`greetings` and `numpy_greetings` are two package examples)
- dependencies between packages (`numpy_greetings` depends on `greetings`)
- external dependencies, requirements (`numpy_greetings` depend on `numpy` as external dep)
- unit tests
- add integration tests
- create packages (useful to deploy lambdas...)
- install dev requirements (like pylint)
- pylint
- force to be in virtual environment
- TODO include in packages also dependencies

## Usage

Create virtual environment:

    virtualenv .penv --python=python3

Active virtual environment:

    source .penv/bin/activate

Install requirements:

    ./run-install.sh

Run tests:

    ./run-test.sh

Run integration tests:

    ./run-test-it.sh

Run linter:

    ./run-lint.sh

Build a zip for each package:

    ./run-build.sh
