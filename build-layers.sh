set -e

function buildLayer() {
  layerName=$1

  echo "Creating package for layer $layerName"

  # Clean temp dir
  rm -rf .tmp
  mkdir -p .tmp/python/layers

  # Copy the code
  cp -p -r ./layers/$layerName ./.tmp/python/layers

  # Clean up
  find ./.tmp -type d -name '__pycache__' -prune -exec rm -rf {} \;
  find ./.tmp -type f -name '*_test.py' -exec rm -r {} \;
  find ./.tmp -type f -name '*.pyc' -exec rm -r {} \;

  # Copy to target dir
  mkdir -p target
  (cd ./.tmp && zip -X -o -D -r - .) > ./target/lambda-layer-$layerName.zip

  # Calculate hash
  md5FileHash=($(md5sum ./target/lambda-layer-$layerName.zip))
  mv ./target/lambda-layer-$layerName.zip ./target/lambda-layer-$layerName-$md5FileHash.zip

  echo "Created package ./target/lambda-layer-$layerName-$md5FileHash.zip"
}

# For each layer
for layerDir in layers/*/ ; do
  # get only the layer name
  layerDir="$(basename $layerDir)"

  # Exclude dir starting with . or _
  if [[ $layerDir =~ ^[^_|\.].*$ ]]; then
    buildLayer $layerDir
  fi
done
