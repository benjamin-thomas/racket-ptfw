## Setup

- raco pkg install fmt
- raco pkg install racket-langserver
  - raco pkg update racket-langserver

## vscode extensions

- Magic Racket
- racket-fmt

## Workflow

Run tests with:

```
./manage/run ./chapter_01/00_functions.rkt
```

---

Run the REPL with:

```
./manage/start_repl FILE
```

Then press `ctrl-d` to reload the REPL