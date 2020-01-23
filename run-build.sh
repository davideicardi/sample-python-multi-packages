set -e

if [ "$VIRTUAL_ENV" = "" ]; then
    echo "Virtual environment not set"
		exit 1
fi

CURRENT_DIR=$PWD

function installRequirementsInTarget() {
  packageName=$1

  requirementsFile="./src/$packageName/requirements.txt"
  target="./src/$packageName/target"

  # if file exists
  if test -f "$CURRENT_DIR/$requirementsFile"; then
    echo "Install requirements for $packageName"

    pip install -r $requirementsFile --target $target --upgrade
  else
    echo "No requirements for $packageName"
  fi
}

function installSrcRequirementsInTarget() {
  # For each src dir
  for subDir in src/*/ ; do
    # get only the name
    subDirName="$(basename $subDir)"

    # Exclude dir starting with . or _
    if [[ $subDirName =~ ^[^_|\.].*$ ]]; then
      installRequirementsInTarget $subDirName
    fi
  done
}

function buildPackage() {
  packageName=$1
  zipSubFolder=$2
  tmpDestination="./.tmp/$zipSubFolder/"
  zipDestination="./target/$packageName.zip"

  echo "Creating package for $packageName"

  # Note: for layers we should use python/layers convention

  # Clean temp dir
  rm -rf .tmp
  mkdir -p $tmpDestination

  # Copy the code
  cp ./src/$packageName/*.py $tmpDestination

  # Copy dependencies
  if test -d "$CURRENT_DIR/src/$packageName/target"; then
    cp -r ./src/$packageName/target/* $tmpDestination
  fi

  # Zip and copy to target dir
  mkdir -p target
  if test -f $CURRENT_DIR/$zipDestination; then
    rm $zipDestination
  fi
  (cd ./.tmp && zip -X -o -D -r - .) > $zipDestination

  echo "Created package $zipDestination"
}

function buildLayer() {
  layerName=$1

  buildPackage $layerName "python/layers"
}

function buildLambda() {
  lambdaName=$1

  buildPackage $lambdaName ""
}

function buildSrc() {
  # For each dir
  for subDir in ./src/*/ ; do
    # get only the name
    subDirName="$(basename $subDir)"

    # Exclude test and test-it
    if [ $subDirName != "test" ] && [ $subDirName != "test-it" ]; then
      # Exclude dir starting with . or _
      if [[ $subDirName =~ ^[^_|\.].*$ ]]; then
        # TODO Find a way to understand if building a layer or a lambda
        # buildLayer $subDirName
        buildLambda $subDirName
      fi
    fi
  done
}

installSrcRequirementsInTarget
buildSrc