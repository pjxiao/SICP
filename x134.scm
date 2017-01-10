; fixed-point
(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enogh? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enogh? guess next)
        next
        (try next))))
  (try first-guess))

; average
(define (average x y)
  (/ (+ x y) 2))

; square
(define (square x) (* x x))

; 1.3.4
(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
               1.0))
(define (cube-sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x (square y))))
               1.0))

; Newton's method
(define dx 0.00001)

(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))

(define (cube x) (* x x x))

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (sqrt x)
  (newtons-method (lambda (y) (- (square y) x))
                 1.0))

; Abstractions and first-class procedures
(define (fixed-point-of-transform g transform guess)
  (fixed-point (tranform g) guess))

; average-damp version
(define (sqrt x)
  (fixed-point-of-transform (lambda (y) (/ x y))
                            average-damp
                            1.0))

(define (sqrt x)
  (fixed-point-of-transform (lambda (y) (- (square y) x))
                            newton-transform
                            1.0))

; 1.40
(define (cubic a b c)
  (lambda (x)
    (+
      (cube x)
      (* a (square x))
      (* b x)
      c)))

; 1.41
(define (inc n) (+ n 1))
(define (double f)
  (lambda (x) (f (f x))))

; 1.42
(define (compose f g)
  (lambda (x) (f (g x))))

; 1.43
(define (repeated f n)
  (if (> n 1)
    (compose f (repeated f (- n 1)))
    f))

; 1.44
(define (smooth f dx)
  (lambda (x)
    (/
      (+
        (f (- x dx))
        (f x)
        (f (+ x dx)))
      3)))

(define (n-fold-smooth f dx n)
  (repeated (smooth f dx) n))

; 1.45
(define (n-th-sqrt x n m)
  (fixed-point
    ((repeated average-damp m) (lambda (y) (/ x (expt y (- n 1)))))
    1.0))
(define (n-th-sqrt x n)
  (let ((m (round (/ (log n) (log 2)))))
    (fixed-point ((repeated average-damp m) (lambda (y) (/ x (expt y (- n 1)))))
      1.0)))

; 1.46
(define (iterative-improve good-enogh? imporove)
  (define (iter guess)
    (if (good-enogh? guess)
      guess
      (iter (imporove guess))))
  iter)

(define (sqrt x)
  (define (good-enogh? guess)
    (< (abs (- (square guess) x))
       tolerance))
  (define (improve guess)
    (average guess (/ x guess)))
  ((iterative-improve good-enogh? improve) 1.0))

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (good-enogh? guess)
    (< (abs (- (f guess) guess))
       tolerance))
  ((iterative-improve good-enogh? f) first-guess))
