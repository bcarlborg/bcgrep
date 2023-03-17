#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>

#define MAX_LINE_LENGTH 1024

// searches a line for the pattern
// line should be a null terminated string
static void search_string(const char *str) { printf("%s\n", str); }

// process the input lines from a file
// one by one.
// Currently, this function can only process at most
// MAX_LINE_LENGTH chars for each line
static void process_file(const char *path) {
  FILE *file = fopen(path, "r");
  if (file == NULL) {
    fprintf(stderr, "ERROR:Could not open file %s\n", path);
    exit(1);
  }

  // seek to the end of the file, then capture the file
  // size so that we know how long the file is. Then rewind
  // so that we can start reading from the beginning
  fseek(file, 0L, SEEK_END);
  size_t fileSize = ftell(file);
  rewind(file);

  char *buffer = (char *)malloc(fileSize + 1);
  if (buffer == NULL) {
    fprintf(stderr, "ERROR: malloc failed");
    exit(1);
  }

  size_t bytes_read = fread(buffer, sizeof(char), fileSize, file);
  if (bytes_read < fileSize) {
    fprintf(stderr, "ERROR: could not read file %s\n", path);
  }

  buffer[bytes_read] = '\0';
  fclose(file);

  search_string(buffer);
}

// R.E.P.L: read, eval, print, loop
// Read a line from stdin, process that line, repeat!
static void repl() {
  char line[MAX_LINE_LENGTH];

  for (;;) {
    if (!fgets(line, sizeof(line), stdin)) {
      fprintf(stderr, "ERROR: could not read line\n");
      exit(1);
    }

    search_string(line);
  }
}

int main(int argc, char *argv[]) {
  // at a minimum, we should at least have
  // the executable name and a pattern as input
  if (argc < 2) {
    fprintf(stderr, "Usage: bcgrep PATTERN [FILE]\n");
    return 1;
  }

  // if there are only two arguments, then we are
  // going to read input from stdin
  if (argc == 2) {
    repl();
  }
  // if there are more than two arguments, we are going
  // to treat the third argument as a file to read from
  else if (argc > 2) {
    process_file(argv[2]);
  }

  return 0;
}
