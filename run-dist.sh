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
    mkdir -p $tmpDestination
    mkdir -p $tmpDestination$packageName

    # Copy the code (python files) in a sub directory
    cp ./src/$packageName/*.py $tmpDestination/$packageName
    # Copy "metadata" (cfg, md)
    find ./src/$packageName -name \*.cfg -exec cp {} ./$tmpDestination \;
    find ./src/$packageName -name \*.md -exec cp {} ./$tmpDestination \;

    # move setup.py in the root
    mv $tmpDestination/$packageName/setup.py $tmpDestination/

    # Run python distribution
    cd .tmp
    python setup.py sdist --dist-dir dist bdist_wheel --dist-dir dist
    cd ..
    rm -vrf ./*.egg-info

    # Copy distribution file to target
    mkdir -p target
    cp $tmpDestination/dist/*.whl target/
    cp $tmpDestination/dist/*.tar.gz target/
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