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

PROGRAM_INPUT_FILE=/tmp/program-input.txt
PROGRAM_OUTPUT_FILE=/tmp/program-output.txt
EXPECTED_OUTPUT_FILE=/tmp/expected-output.txt

cleanup_helper_files () {
	rm -f $PROGRAM_INPUT_FILE $PROGRAM_OUTPUT_FILE $EXPECTED_OUTPUT_FILE
}

######################################################################
# Test case 1
# searching stdin with empty search pattern should echo the input
# straight to the output
######################################################################

# we will create an input file with a few lines of text
touch $PROGRAM_INPUT_FILE
{ echo "this is a test line 1";
echo "and this here be a test line 2";
echo "testy 3 test whoopie"; } >> $PROGRAM_INPUT_FILE

# then we will pass that input file to stdin and capture stdout
$BCGREP_EXECUTABLE '' < $PROGRAM_INPUT_FILE > $PROGRAM_OUTPUT_FILE 2>&1

# expect the input file and the output file to be the same
if ! diff $PROGRAM_INPUT_FILE $PROGRAM_OUTPUT_FILE
then
	>&2 echo "when given empty input search pattern, and reading from stdin, output should match input"
	exit 1
fi

# now lets cleanup our helper files
cleanup_helper_files

######################################################################
# Test case 2
# searching a file with empty search pattern should echo the input
# straight to the output
######################################################################


# we will create an input file with a few lines of text
touch $PROGRAM_INPUT_FILE
{ echo "this is a test line 1";
echo "and this here be a test line 2"; 
echo "testy 3 test whoopie"; } >> $PROGRAM_INPUT_FILE

# then we will pass that input file to stdin and capture stdout
$BCGREP_EXECUTABLE '' $PROGRAM_INPUT_FILE > $PROGRAM_OUTPUT_FILE 2>&1

# expect the input file and the output file to be the same
if ! diff $PROGRAM_INPUT_FILE $PROGRAM_OUTPUT_FILE
then
	>&2 echo "when given empty input search pattern, and reading from a file, output should match input"
	exit 1
fi


# now lets cleanup our helper files
cleanup_helper_files


