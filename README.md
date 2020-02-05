
Sample to show how to organize a python project with multi packages and deployments.

## Features

- multiple packages (`greetings` and `numpy_greetings` are two package examples)
- dependencies between packages (`numpy_greetings` depends on `greetings`)
- external dependencies, requirements (`numpy_greetings` depend on `numpy` as external dep)
- unit tests
- add integration tests
- create build zip packages (useful to deploy AWS lambdas and layers...)
- create PyPi packages
- install dev requirements (like pylint)
- pylint src directory
- check that scripts are executed inside a virtual environment

## Usage

Create virtual environment:

    virtualenv .penv --python=python3

Active virtual environment:

    source .penv/bin/activate

Install requirements:

    ./run-install.sh

Run tests:

    ./run-test.sh
    # run a single test class
    ./run-test.sh test_package.test_module[.TestSuite][.test_method]

Run integration tests:

    ./run-test-it.sh
    # run a single test class
    ./run-test-it.sh test_package.test_module[.TestSuite][.test_method]

Run linter:

    ./run-lint.sh

Build a zip for each package (for lambda packages):

    ./run-build.sh

Build a PyPi distribution for each package containing `setup.py`:

    ./run-dist.sh

Clean outputs:

    ./run-clean.sh
