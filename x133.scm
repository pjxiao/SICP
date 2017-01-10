; half-interval method;{{{
(define (average a b)
  (/ (+ a b) 2))

(define (search f neg-point pos-point)
  (define (close-enogh? x y)
    (< (abs (- x y)) 0.001))
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enogh? neg-point pos-point)
      midpoint
      (let ((test-value (f midpoint)))
        (cond ((positive? test-value)
               (search f neg-point midpoint))
               ((negative? test-value)
                (search f midpoint pos-point))
               (else midpoint))))))


(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (positive? a-value))
           (search f b a))
          (else
            (error "Values are not of opposite sign" a b)))));}}}

; fixed-point
(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enogh? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (display next)
      (newline)
      (if (close-enogh? guess next)
        next
        (try next))))
  (try first-guess))


; sqrt
(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))

; 1.35
(define phi
  (fixed-point (lambda (x) (+ 1 (/ 1 x)))
  1.0))

; 1.36
(fixed-point (lambda (x) (/ (log 1000) (log x))) 2)
(newline)
; average damping
(fixed-point (lambda (x) (/ (+ x (/ (log 1000) (log x))) 2)) 2)

; 1.37a
(define (cont-frac n d k)
  (define (recurse i)
        (if (< i k)
          (/ (n i) (+ (d i) (recurse (+ 1 i))))
          (/ (n i) (d i))))
  (recurse 1))

; 1.37b
(define (cont-frac-iter n d k)
  (define (iter i result)
    (let ((d (d i))
          (n (n i)))
        (if (> i k)
          result
          (iter (+ 1 i) (/ n (+ d result))))))
  (iter 1 0))

; 1.38
(define (e-d i)
  (if (= 0 (remainder (+ 1 i) 3))
    (/ (* 2 (+ 1 i)) 3)
    1))

(define e
  (+ 2
     (cont-frac
         (lambda (i) 1.0)
         e-d
         10)))

; 1.39
(define (square x) (* x x))

(define (tan-cf x k)
  (define (n i)
    (if (= i 1)
      x
      (- (square x))))
  (define (d i)
    (- (* 2 i) 1))
  (cont-frac n d k))
