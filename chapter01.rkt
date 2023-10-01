#lang racket

(require rackunit)

; echo ./chapter01.rkt | entr -c racket /
; echo ./chapter01.rkt | entr -c bash -c 'racket ./chapter01.rkt; date'

; `cons` does not necessarily create a list. It can produce a pair.
(check-equal? (cons 1 2) '(1 . 2))

; We can produce a list, with the second arg being an empty list.
(check-equal? (cons 1 '()) '(1))

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
(check-equal? (first '(1 2 3)) 1)

; Same thing with `cdr` and `rest`
(check-equal? (cdr (cons 1 2)) 2)
(check-equal? (cdr '(1 2 3)) '(2 3))
(check-equal? (rest '(1 2 3)) '(2 3))

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
(check-equal? (append '(1 2 3) '(4 5 6))
	      '(1 2 3 4 5 6))

; Range
(check-equal? (range 4) '(0 1 2 3))
(check-equal? (range 1 5) '(1 2 3 4))
(check-equal? (range 0 10 2) '(0 2 4 6 8))

; Make list
(check-equal? (make-list 3 'me)
	      '(me me me))

; Check if a list is empty, with `null?`
(check-true (null? '()))
(check-false (null? '(1)))

; Find the value in a list
(check-equal? (index-of '(1 4 8 0 3 2) 0)
	      3)
(check-equal? (index-of '(1 4 8 0 3 2) 99)
	      #f)

; `member` returns the tail of a match, a truthy value. Or false
(check-equal? (member 3 '(1 2 3 4 5 6))
	      '(3 4 5 6))
(check-equal? (member 99 '(1 2 3 4 5 6))
	      #f)
(check-equal? (member 4 '(1 2 3 (4 5) 6))
	      #f)
(check-equal? (member '(4 5) '(1 2 3 (4 5) 6))
	      '((4 5) 6))
