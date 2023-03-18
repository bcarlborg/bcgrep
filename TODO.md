# TODOs
A very lightweight tracking mechanism to keep track of planned work

## Up next
- [ ] figure out a nice way to use a unified getline function between the stdin input and a file's input
  - this feels like it will most likely requiring breaking out another translation unit file, and having
    that file maintain its own state about the input. It would probably have some global state that stores
    a pointer to the file, and then based on if that is stdin or some other file, we either readmore
    from there or read another line from a buffer that we've allocated.

## Completed
- [x] create a test for `bcgrep '' stdin` and `bcgrep '' somefile`. It should simply echo out the same text
  - I think maybe using some sort of named pipe pattern for this could be good. Using the test script to 
    write to the named pipe, and then letting the program read from it.
  - [this stackoverflow question](https://stackoverflow.com/questions/66260793/bash-howto-write-read-to-from-a-named-pipe-without-aborting-after-first-sending) has a an interesting solution that allows you to write to a fifo without closing the fifo.
  - solution: ultimately, I think i was just over thinking this one a bit... I really just needed to redirect an input file to stdin. That trick in the stack overflow link above is still pretty nifty though!
