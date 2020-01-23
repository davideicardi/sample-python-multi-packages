
Sample python project to show how to organize a python project with multi packages

## Features

- multiple packages (greetings and numpy_greetings)
- dependencies between packages (numpy_greetings depends on greetings)
- external dependencies (numpy_greetings depend on numpy)
- unit tests
- add integration tests
- install requirements
- create packages (useful to deploy lambdas...)
- install dev requirements (like pylint)
- pylint
- TODO force to be in venv
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

    ./run-it.sh

Build a zip for each package:

    ./run-build.sh
