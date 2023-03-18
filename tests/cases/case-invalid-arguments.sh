#!/bin/sh

# This test case expects the first argument to be a path to
# a bcgrep executable to test

# lets check that the first argument passed to this function is
# an executable
if [ ! -x "$1" ]
then
	>&2 echo "first argument to this executable should be a path to an executable bcgrep file"
	exit 1
fi

BCGREP_EXECUTABLE="$1"
PROGRAM_OUTPUT_FILE=/tmp/program-output.txt
EXPECTED_OUTPUT_FILE=/tmp/expected-output.txt
cleanup_helper_files () {
	rm -f $PROGRAM_OUTPUT_FILE $EXPECTED_OUTPUT_FILE
}

######################################################################
# Test case 1
# Running program with no inputs should exit with non-zero status
######################################################################

# first, lets check that running our program with no inputs
# exits with a non-zero status
if $BCGREP_EXECUTABLE > /dev/null 2>&1
then
	>&2 echo "expected bcgrep to exit with non-zero status when run without inputs"
	exit 1
fi


######################################################################
# Test case 2
# Running the program with no inputs should also exit with the expected
# error message
######################################################################

# next, lets check that running our program with no inputs
# outputs the correct error message

# lets put our expected output somewhere that we can reference it later
echo "Usage: bcgrep PATTERN [FILE]" > $EXPECTED_OUTPUT_FILE

# lets run our program without inputs and store the stderr message
$BCGREP_EXECUTABLE 2> $PROGRAM_OUTPUT_FILE

# now lets compare the outputs
if ! diff /tmp/expected-output.txt /tmp/program-output.txt
then
	>&2 echo "expected bcgrep to print 'Usage: bcgrep PATTERN file to stderr"
	cleanup_helper_files
	exit 1
fi

cleanup_helper_files


# and if we make it all the way down here, we have run our program without error!
exit 0
