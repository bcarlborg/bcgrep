#include <stdio.h>

char *search_pattern;

int main(int argc, char *argv[]) {
  // at a minimum, we should at least have
  // the executable name and a pattern as input
  if (argc < 2) {
    fprintf(stderr, "Usage: bcgrep PATTERN file\n");
    return 1;
  }

  for (int i = 0; i < argc; i++) printf("%s\n", argv[i]);

  return 0;
}
