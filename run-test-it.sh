if [ "$VIRTUAL_ENV" = "" ]; then
    echo "Virtual environment not set"
		exit 1
fi

cd src
python -m unittest discover -s test-it -t .
