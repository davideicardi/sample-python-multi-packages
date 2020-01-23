set -e

function installRequirements() {
  packageName=$1

  echo "Install requirements for $packageName"

  pip install -r ./$packageName/requirements.txt

}

installRequirements 'numpy_greetings'

