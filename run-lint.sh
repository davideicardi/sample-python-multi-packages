if [ "$VIRTUAL_ENV" = "" ]; then
    echo "Virtual environment not set"
		exit 1
fi

function lint() {
  packageName=$1

  echo "pylint for $packageName"

  pylint "$packageName"
}

function lintSrc() {
  # For each dir
  for subDir in ./*/ ; do
    # get only the name
    subDirName="$(basename $subDir)"

    # Exclude test and test-it
    if [ $subDirName != "test" ] && [ $subDirName != "test-it" ]; then
      # Exclude dir starting with . or _
      if [[ $subDirName =~ ^[^_|\.].*$ ]]; then
        lint $subDirName
      fi
    fi
  done
}

cd src || exit
lintSrc