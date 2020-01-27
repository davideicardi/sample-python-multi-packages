set -e

if [ "$VIRTUAL_ENV" = "" ]; then
    echo "Virtual environment not set"
		exit 1
fi

CURRENT_DIR=$PWD

function createDist() {
  packageName=$1

  # if setup.py file exists
  setupFile="./src/$packageName/setup.py"
  if test -f "$CURRENT_DIR/$setupFile"; then
    echo "Create distribution for $packageName"

    tmpDestination="./.tmp/"

    # Clean temp dir
    rm -rf .tmp
    mkdir $tmpDestination

    # Copy the code (python files, cfg, md)
    cp ./src/$packageName/*.py $tmpDestination
    find ./src/$packageName -name \*.cfg -exec cp {} ./$tmpDestination \;
    find ./src/$packageName -name \*.md -exec cp {} ./$tmpDestination \;

    # Run python distribution
    python .tmp/setup.py sdist --dist-dir .tmp/dist bdist_wheel --dist-dir .tmp/dist
    rm -vrf ./*.egg-info

    # Copy distribution file to target
    mkdir -p target
    cp ./.tmp/dist/*.whl target/
    cp ./.tmp/dist/*.tar.gz target/
  fi
}

function createSrcDist() {
  # For each src dir
  for subDir in src/*/ ; do
    # get only the name
    subDirName="$(basename $subDir)"

    # Exclude dir starting with . or _
    if [[ $subDirName =~ ^[^_|\.].*$ ]]; then
      createDist $subDirName
    fi
  done
}

createSrcDist
