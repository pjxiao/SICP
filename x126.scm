(use srfi-11)
(use srfi-27)

; runtime
; http://sicp.g.hatena.ne.jp/n-oohira/20090122
(define (runtime)
  (let-values (((a b) (sys-gettimeofday)))
              (+ (* a 1000000) b)))
; Square
(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-diviser)
(cond ((> (square test-diviser) n) n)
      ((divides? test-diviser n) test-diviser)
      (else (find-divisor n (+ test-diviser 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

; Fermat test
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
          (remainder (* base (expmod base (- exp 1) m))
                     m))))

(define (fermat-test n)
   (define (try-it a)
     (= (expmod a n n) a))
   (try-it (+ 1 (random-integer (- n 1)))))

(define (fast-prime? n times)
   (cond ((= times 0) #t)
         ((fermat-test n) (fast-prime? n (- times 1)))
         (else #f)))

; 1.21
;(display (smallest-divisor 199))
;(newline)
;(display (smallest-divisor 1999))
;(newline)
;(display (smallest-divisor 19999))
;(newline)

; 1.22
(define (time-prime-test n)
  (newline)
  (display n)
  (start-prime-time n (runtime)))

(define (start-prime-time n start-time)
  (if (prime? n)
    (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
  (newline))

(define (search-for-primes start end)
    (cond ((<= start end) (time-prime-test start)
                         (search-for-primes (+ start 1) end))))

; (search-for-primes 1000 1019)
; (search-for-primes 10000 10037)
; (search-for-primes 100000 100043)
; (search-for-primes 1000000 1000039)

; 1.23
(define (start-time f start end)
  (define (run start-time)
    (f start end)
    (newline)
    (display (- (runtime) start-time)))
    (newline)
  (run (runtime)))

(define (search-for-primes-2 start end)
  (if (even? start)
    (search-for-primes-2 (+ start 1) end)
    (cond ((<= start end) (time-prime-test start)
                         (search-for-primes (+ start 2) end)))))
