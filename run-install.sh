set -e

if [ "$VIRTUAL_ENV" = "" ]; then
    echo "Virtual environment not set"
		exit 1
fi

function installRequirements() {
  packageName=$1

  echo "Install requirements for $packageName"

  pip install -r ./$packageName/requirements.txt
}

installRequirements 'numpy_greetings'

