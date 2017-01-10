; Square
(define (square x) (* x x))


; Recursive process
(define (expt b n)
  (if (= n 0)
    1
    (* b (expt b (- n 1)))))


; Iterative process
(define (expt b n)
  (define (iter counter product)
    (if (= counter 0)
      product
      (iter (- counter 1)
            (* b product))))
  (iter n 1))


; Successive squaring
(define (even? n)
  (= (remainder n 2) 0))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))


; 9
; b ^ 9, 1
; (b ^ (9 - 1)), b
; (b ^ 8), b
; ((b ^ 2) ^ (8 / 2)), b
; ((b ^ 2) ^ 4), b
; (((b ^ 2) ^ 2) ^ (4 / 2)), b
; (((b ^ 2) ^ 2) ^ 2), b
; ((((b ^ 2) ^ 2) ^ 2) ^ (2 / 2)), b
; ((((b ^ 2) ^ 2) ^ 2) ^ 1), b
; (c ^ 1), b
; c, c * b

; 1.16
(define (fast-expt-iter b n)
  (define (iter b n a)
    (cond ((= n 0) a)
          ((even? n) (iter (square b)
                           (/ n 2)
                           a))
          (else (iter
                  b
                  (- n 1)
                  (* a b)))))
  (iter b n 1))

; 1.17
(define (* a b)
  (if (= b 0)
    0
    (+ a (* a (- b 1)))))

(define (double a) (+ a a))
(define (halve a) (/ a 2.0))

(define (fast-mul a b)
  (cond ((= b 0) 0)
        ((even? b) (fast-mul (double a) (halve b)))
        (else (+ a (fast-mul a (- b 1))))))

; 1.18
(define (fast-mul-iter a b)
  (define (iter a b c)
    (cond ((= b 0) c)
          ((even? b) (iter (double a) (halve b) c))
          (else (iter
                  a
                  (- b 1)
                  (+ a c)))))
  (iter a b 0))

; 1.19
; a <- bq + aq + ap
; b <- bp + aq
;
; a' <- (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
; a' <- bpq + aqq + bqq + aqq + apq + bpq + apq + app
; a' <- 2bpq + 2aqq + 2apq + bqq + app
; a' <- (2pq + qq)b + (2pq + qq)a + (pp + qq)a
;
; b' <- bp + aq
; b' <- (bp + aq)p + (bq + aq + ap)q
; b' <- bpp + apq + bqq + aqq + apq
; b' <- (2pq + qq)a + (pp + qq)b
; -> p' =  pp + qq
; -> q' = 2pq + qq
(define (fib n)
  (define (iter a b p q count)
    (cond ((= count 0) b)
          ((even? count)
           (iter a
                 b
                 (+ (square p) (square q))
                 (+ (* 2 p q) (square q))
                 (/ count 2)))
          (else (iter (+ (* b q) (* a q) (* a p))
                      (+ (* b q) (* a q))
                      p
                      q
                      (- count 1)))))
  (iter 1 0 0 1 n))
