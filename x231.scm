(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

; 2.53

; #f
(memq 'apple '(pear banana prune))
; (apple pear)
(memq 'apple '(x (apple sauce) y apple pear))
; (a b c)
(list 'a 'b 'c)
; ((george))
(list (list 'george))
; ((y1 y2))
(cdr '((x1 x2) (y1 y2)))
; (y1 y2)
(cadr '((x1 x2) (y1 y2)))
; #f
(pair? (car '(a short list)))
; #f
(memq 'red '((red shoes) (blue socks)))
; (red shoes blue socks)
(memq 'red '(red shoes blue socks))

;2.54
(define (equal? xs ys)
  (if (or (null? xs) (null? ys))
    #t
    (and (eq? (car xs) (car ys))
         (equal? (cdr xs) (cdr ys)))))
