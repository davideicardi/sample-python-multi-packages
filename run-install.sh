set -e

function installEnvRequirements() {
  pip install pylint
}

function installRequirements() {
  packageName=$1

  echo "Install requirements for $packageName"

  pip install -r ./$packageName/requirements.txt

}

installEnvRequirements
installRequirements 'numpy_greetings'
