# BCGREP
This is my simple implementation of grep. This program was written purely for educational purposes and makes no garuntees about is performance or reliability.

## Program usage
Work in progress! I will update this readme once the program evolves enough to be usable!

## Project dependencies
In oder to build and run this project, you mearly need an installation of GNU make and a c11 compatible compiler. All scripts in this directory are written in posix compliant shell, and therefore can be run by most if not all shells (use dash for best results).

## Buid instructions
This program uses a simple makefile that can be run with any reasonably up to date version of GNU Make.
- `make bcgrep`: build the program executable in `./bin` (this is the default rule that will be run by `make` with no arguments)
- `make tests`: build the program and run all tests in `./tests/cases`
- `make debug`: builds an executable in `./debug` with debug symbols appropriate for running the program in the debugger
- `make clean`: remove all intermediate object files and executables

## Tests
The test framework for this project is rather spartan. Each test is a shell script that accepts a bcgrep executable as an argument to run against. When a test succeeds, it should exit with status 0. when a test fails, it should exit with a non zero status.

`make tests` will execute all test files in the `./tests/cases` directory whose names begin with `case-`.

