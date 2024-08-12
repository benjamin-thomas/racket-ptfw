#lang racket

(require rackunit)

; echo ./chapter01.rkt | entr -c racket /
; echo ./chapter01.rkt | entr -c bash -c 'racket ./chapter01.rkt; date'

; `cons` does not necessarily create a list. It can produce a pair.
(check-equal? (cons 1 2) '(1 . 2))

; We can produce a list, with the second arg being an empty list.
(check-equal? (cons 1 '()) '(1))

; Different ways to build lists
(check-equal? '(1 2 3) (cons 1 (cons 2 (cons 3 '()))))
(check-equal? '(1 2 3) (cons 1 (cons 2 (cons 3 null))))
(check-equal? '(1 2 3) (list 1 2 3))
(check-equal? '(1 2 3) '(1 2 3))
(check-equal? '(1 2 3) (quote (1 2 3)))
(check-equal? '(0 0 0) (make-list 3 0))

; So `cons` always produces a pair, but may not procude a list
(check-true (pair? (cons 1 2)))
(check-true (pair? (cons 1 '())))
(check-false (list? (cons 1 2)))
(check-true (list? (cons 1 '())))

; Typically, `cons` is use to add an element the beginning of a list.
(check-equal? (cons 0 '(1 2 3)) '(0 1 2 3))

; `car` returns the head of a "cons cell". So it works on a list and a pair.
(check-equal? (car (cons 1 2)) 1)
(check-equal? (car '(1 2 3)) 1)
(check-equal? (first '(1 2 3)) 1) ; `first` only works on lists (crashes on pairs)

; Same thing with `cdr` and `rest`
(check-equal? (cdr (cons 1 2)) 2)
(check-equal? (cdr '(1 2 3)) '(2 3))
(check-equal? (rest '(1 2 3)) '(2 3)) ; `rest` only works on lists (crashes on pairs)

; The greatest list accessor is `tenth`.
(check-equal? (tenth '(1 2 3 4 5 6 7 8 9 10)) 10)

; It's possible to get the value at an index with `list-ref`
(check-equal? (list-ref '(1 2 3) 0) 1)
(check-equal? (list-ref '(1 2 3) 1) 2)
(check-equal? (list-ref '(1 2 3) 2) 3)
; (check-equal? (list-ref '(1 2 3) 99) 3) --> runtime error

; Length of a list
(check-equal? (length '(a b c)) 3)

; Reverse a list
(check-equal? (reverse '(a b c)) '(c b a))

; Sort
(check-equal? (sort '(3 1 2) <) '(1 2 3))
(check-equal? (sort '(3 1 2) >) '(3 2 1))

; Append
(check-equal? (append '(1 2 3) '(4 5 6)) '(1 2 3 4 5 6))

; Range
(check-equal? (range 4) '(0 1 2 3))
(check-equal? (range 1 5) '(1 2 3 4))
(check-equal? (range 0 10 2) '(0 2 4 6 8))

; Make list
(check-equal? (make-list 3 'me) '(me me me))

; Check if a list is empty, with `null?`
(check-true (null? '()))
(check-true (null? null))
(check-false (null? '(1)))

; Find the value in a list
(check-equal? (index-of '(1 4 8 0 3 2) 0) 3)
(check-equal? (index-of '(1 4 8 0 3 2) 99) #f)

; `member` returns the tail of a match, a truthy value. Or false
(check-equal? (member 3 '(1 2 3 4 5 6)) '(3 4 5 6))
(check-equal? (member 99 '(1 2 3 4 5 6)) #f)
(check-equal? (member 4 '(1 2 3 (4 5) 6)) #f)
(check-equal? (member '(4 5) '(1 2 3 (4 5) 6)) '((4 5) 6))

; Defining variables
; ==================

; We bind the value `123` to the identifier `a`.
(define a 123)
(check-equal? a 123)

; We can bind in parallel
(define-values (x y z) (values 1 2 3))
(check-equal? (list x y z) '(1 2 3))

; We can `assign` a new value (mutate) to an existing identfier with `set!`
(set! a 124)
(check-equal? a 124)

; Identifiers can contain characters that would be rejected in other languages:
(define 3x2 6)
(define 3*2 6)
(define 3×2 6)
(define 3-hellos "Hello, hello, hello!")
(check-equal? (list 6 6 6 "Hello, hello, hello!") (list 3x2 3*2 3×2 3-hellos))

; Optional arguments may be specified with a keyword syntax: `#:key val`
; `~r` converts a rational number to its string representation
(check-equal? (~r pi) "3.141593")
(check-equal? (~r pi #:precision 2) "3.14")

(define lsa '(1 2 3))
(define lsb '(1 2 3))
(define lsa2 lsa)
; Equality, by value
(check-true (equal? lsa lsb))

; Equality, by reference (for non-primitives)
(check-false (eq? lsa lsb))
(check-true (eq? lsa lsa2))

; See this behaviour for primitives --> it's unclear if this behaviour is only related to numbers
(define a2 124)
(check-true (eq? a a2))

; For numbers, we can use `=`
(check-true (= a 124))

; Strings
; =======

; A single character may be represented with #\ followed by a litteral char. Note that this represent a Unicode value
(check-true (equal? #\a #\u0061))
(check-true (equal? #\a #\u61))
(check-equal? (char->integer #\a) 97)
(check-equal? (integer->char 97) #\a)
(check-true (char-alphabetic? #\a))
(check-false (char-alphabetic? #\0))
(check-true (char-numeric? #\0))
(check-false (char-numeric? #\a))

(check-equal? '(#\u2665 #\u2666 #\u2660 #\u2663) '(#\♥ #\♦ #\♠ #\♣))
(check-equal? "Happy #\u263a" "Happy #☺")

; Join strings with `string-append`
(check-equal? (string-append "Luke, " "I am " "your father!") "Luke, I am your father!")

; Index into strings with `string-ref`
(check-equal? (string-ref "abc" 0) #\a)
(check-equal? (string-ref "abc" 1) #\b)
(check-equal? (string-ref "abc" 2) #\c)

; `string` creates a mutable string
(define mstr1 (string #\h #\e #\l #\l))
(check-equal? mstr1 "hell")
; Change a char
(string-set! mstr1 0 #\y)
(check-equal? mstr1 "yell")

; Another way to create a string
(define mstr2 (string-copy "Wow"))
(check-equal? mstr2 "Wow")
(string-set! mstr2 1 #\space)
(check-equal? mstr2 "W w")

; And another way
(define mstr3 (make-string 10 #\X))
(string-set! mstr3 5 #\O)
(check-equal? mstr3 "XXXXXOXXXX")

; Compute the length of a string
(check-equal? (string-length "abc") 3)

; Access part of a string
; Fails if end is out of bounds
; Fails if start is negative
(check-equal? (substring "abc" 0 2) "ab")

; String manipulation
(check-equal? "Hello World" (string-titlecase "hello world"))
(check-equal? "HELLO" (string-upcase "hello"))
(check-equal? "hello" (string-downcase "HELLO"))

; Compare
(check-true (string<=? "aaa" "bbb"))
(check-false (string<=? "bbb" "aaa"))

; Equality
(check-true (string=? "abc" "abc"))

; Ignore a bunch of other functions...

; Vectors
; =======

(check-equal? '(1 2 3) (list 1 2 3))
(check-equal? '(1 2 3.141592653589793) (list 1 2 pi)) ; eval first
(check-equal? #(1 2 3) (vector 1 2 3))
(check-equal? #(1 2 3.141592653589793) (vector 1 2 pi)) ; eval first
(check-equal? '#(1 2 3) (vector 1 2 3)) ; the quote is implied

; Using the `#` syntax creates an immutable vector
(define v (vector 1 2 3))
(vector-set! v 0 -1) ; would fail on v = #(1 2 3)
(check-equal? v #(-1 2 3))
(check-equal? -1 (vector-ref v 0))
