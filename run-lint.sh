function installPylint() {
  pylint_path=$(which pylint)
  echo $pylint_path
  if [ -z "$pylint_path" ]
  then
        sudo apt-get install pylint
  fi
}

installPylint
pylint greetings numpy_greetings