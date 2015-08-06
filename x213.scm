(define (cons x y)
  (define (dispatch m)
    (cond ((= m 0) x)
          ((= m 1) y)
          (else (error "Argument not 0 or 1 -- CONS" m))))
  dispatch)

(define (car z) (z 0))
(define (cdr z) (z 1))

; 2.4

(define (cons x y) (lambda (m) (m x y)))
(define (car z) (z (lambda (p q) p)))
(define (cdr z) (z (lambda (p q) q)))

; (car (lambda (m) (m x y)))
; ((lambda (m) (m x y)) (lambda (p q) p))
; ((lambda (p q) p) x y)
; ((lambda (x y)) x)
; x

; 2.5
(define (cons x y) (* (expt 2 x) (expt 3 y)))
(define (div-n x n)
  (define (iter x count)
    (if (> (remainder x n) 0)
      count
      (iter (/ x n) (+ count 1))))
  (iter x 0))

(define (car z) (div-n z 2))
(define (cdr z) (div-n z 3))

; 2.6
; Hint: http://d.hatena.ne.jp/tanakaBox/20070723/1186253252
(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))

(define (inc n) (+ n 1))
(define (to-s z)
  ((z inc) 0))

(define (add a b)
  (lambda (f)
    (lambda (x) ((a f) ((b f) x)))))
