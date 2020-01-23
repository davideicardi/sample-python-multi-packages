set -e

function buildLambda() {
  lambdaName=$1

  echo "Creating package for lambda $lambdaName"

  # Clean temp dir
  rm -rf .tmp
  mkdir -p .tmp

  # Copy the code
  cp -p -r ./lambda/$lambdaName ./.tmp/

  # Clean up
  find ./.tmp -type d -name '__pycache__' -prune -exec rm -rf {} \;
  find ./.tmp -type f -name '*_test.py' -exec rm -r {} \;
  find ./.tmp -type f -name '*.pyc' -exec rm -r {} \;

  # Copy to target dir
  mkdir -p target
  (cd ./.tmp/$lambdaName && zip -X -o -D -r - .) > ./target/lambda-$lambdaName.zip

  # Calculate hash
  md5FileHash=($(md5sum ./target/lambda-$lambdaName.zip))
  mv ./target/lambda-$lambdaName.zip ./target/lambda-$lambdaName-$md5FileHash.zip

  echo "Created package ./target/lambda-$lambdaName-$md5FileHash.zip"
}

# For each lambda
for lambdaDir in lambda/*/ ; do
  # get only the lambda name
  lambdaDir="$(basename $lambdaDir)"

  # Exclude dir starting with . or _
  if [[ $lambdaDir =~ ^[^_|\.].*$ ]]; then
    buildLambda $lambdaDir
  fi
done
