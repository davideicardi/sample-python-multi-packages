if [ "$VIRTUAL_ENV" = "" ]; then
    echo "Virtual environment not set"
		exit 1
fi

python -m unittest discover -s test -t .
