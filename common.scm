(define-module common
  (export square accumulate))
(select-module common)

; square
(define (square x) (* x x))

; accumulate
(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))
