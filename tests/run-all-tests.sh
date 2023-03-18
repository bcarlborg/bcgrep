#!/bin/sh

# this program executes a bcgrep executable against
# every test in the cases directory. the cases directory
# is assumed to be in the same directory as this runner.
# this program only runs case files that beging with the
# prefix case-

# this program requires two arguments
# 1: a path to an executable bcgrep file
# 2: the directory containing all test cases to run

# check that we have the correct number of inputs
if [ ! $# -eq 2 ]
then
	>&2 echo "Usage: runner.sh bcgrep-executable"
	exit 1
fi

# The our program expects a path to an executable
# to run these tests with as the first argument.
if [ ! -x "$1" ]
then
	>&2 echo "Error: first argument is not an executable file"
	exit 1
fi
BCGREP_EXECUTABLE=$1

# The our program expects a directory of tests as the
# second argument
if [ ! -d "$2" ]
then
	>&2 echo "Error: second argument is not a directory"
	exit 1
fi
TEST_CASES_DIRECTORY=$2


# we will keep track of the status of the tests
# we are going to run here
TESTS_RAN_CLEANLY=true

echo "BEGINNING TESTS"

# loop over each case- file in the test directory
for case_file in "$TEST_CASES_DIRECTORY"/case-*; do

	# give outselves a new line before every test run
	echo 

	# first lets be sure we can execute this file
	if [ ! -x "$case_file" ]
	then
		"failed to start running $case_file"
		echo 
		break
	fi

	echo "RUNNING: $case_file"

	if $case_file "$BCGREP_EXECUTABLE"
	then
		echo "----> TEST PASSED"
	else
		# error messages get sort of crowded... lets add a newline
		# so we can see more
		echo 
		echo "----> TEST FAILED -- see error message above"
		TESTS_RAN_CLEANLY=false
	fi

done

# one more newline because I like things spaceyyyy
echo

if [ "$TESTS_RAN_CLEANLY" = true ]
then
	exit 0
else
	exit 1
fi
