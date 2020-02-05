if [ "$VIRTUAL_ENV" = "" ]; then
    echo "Virtual environment not set"
    exit 1
fi

TEST_PARAM=$1
TEST_COMMAND="discover -s test_it -t ."
if [ "$TEST_PARAM" != "" ]; then
  TEST_COMMAND="test_it.$TEST_PARAM"
fi

cd src || exit

eval "python -m unittest $TEST_COMMAND"
