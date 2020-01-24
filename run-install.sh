set -e

if [ "$VIRTUAL_ENV" = "" ]; then
    echo "Virtual environment not set"
		exit 1
fi

CURRENT_DIR=$PWD

function installDevRequirements() {
  pip install 'pylint==2.4.4'
  pip install 'mock==3.0.5'
}

function installRequirements() {
  packageName=$1

  requirementsFile="./src/$packageName/requirements.txt"
  target="./src/$packageName/target"

  # if file exists
  if test -f "$CURRENT_DIR/$requirementsFile"; then
    echo "Install requirements for $packageName"

    pip install -r $requirementsFile
  else
    echo "No requirements for $packageName"
  fi
}

function installSrcRequirements() {
  # For each src dir
  for subDir in src/*/ ; do
    # get only the name
    subDirName="$(basename $subDir)"

    # Exclude dir starting with . or _
    if [[ $subDirName =~ ^[^_|\.].*$ ]]; then
      installRequirements $subDirName
    fi
  done
}

installDevRequirements
installSrcRequirements
