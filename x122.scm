(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(define (fib n)
  (define (iter a b count)
    (if (= count 0)
      b
      (iter (+ a b) a (- count 1))))
  (iter 1 0 n))

(define (count-change amount)
  (define (cc amount kinds-of-conins)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (= kinds-of-conins 0)) 0)
          (else (+ (cc amount
                       (- kinds-of-conins 1))
                   (cc (- amount
                          (first-denomination kinds-of-conins))
                       kinds-of-conins)))))
  (define (first-denomination kinds-of-conins)
    (cond (( = kinds-of-conins 1) 1)
          (( = kinds-of-conins 2) 5)
          (( = kinds-of-conins 3) 10)
          (( = kinds-of-conins 4) 25)
          (( = kinds-of-conins 5) 50)))
  (cc amount 5))


; 1.11
(define (f n)
  (if (< n 3)
    n
    (+ (f (- n 1))
       (* 2 (f (- n 2)))
       (* 3 (f (- n 3))))))

(define (f-iter n)
  (define (iter a b c counter)
    (if (> counter n)
      a
      (iter (+ a (* 2 b) (* 3 c))
            a
            b
            (+ counter 1))))
  (if (< n 3)
     n
     (iter 2 1 0 3))) ; 2, 1, 0 = f(2), f(1), f(0)

; 1.12
(define (pascal-triangle row col)
  (if (or (= col 1) (= row col))
    1
    (+ (pascal-triangle (- row 1) (- col 1))
       (pascal-triangle (- row 1) col))))
