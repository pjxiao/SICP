; square
(define (square x) (* x x))

(define (list-ref items n)
  (if (= n 0)
    (car items)
    (list-ref (cdr items) (- n 1))))


(define (length items)
  (if (null? items)
    0
    (+ 1 (length (cdr items)))))

(define (length items)
  (define (length-iter a count)
    (if (null? a)
      count
      (length-iter (cdr a) (+ count 1))))
  (length-iter items 0))


; 2.17
(define (last-pair items)
  (define (iter a last)
    (if (null? a)
      last
      (iter (cdr a) a)))
  (iter items (list)))

; 2.18
(define (reverse items)
  (define (iter a reversed)
    (if (null? a)
      reversed
      (iter (cdr a) (cons (car a) reversed))))
  (iter items (list)))

; 2.19
(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define no-more? null?)
(define (first-denomination coin-values) (car coin-values))
(define (except-first-denomination coin-values) (cdr coin-values))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
          (+ (cc amount
                 (except-first-denomination coin-values))
             (cc (- amount
                    (first-denomination coin-values))
                 coin-values)))))

; 2.20
(define (same-parity . l)
  (define (get-parity n) (modulo n 2))
  (define (flt parity l)
    (if (null? l)
      l
      (let ((n (car l))
            (left (cdr l)))
        (if (= (get-parity n) parity)
          (cons n (flt parity left))
          (flt parity left)))))
  (let ((x (car l)))
      (flt (get-parity x) l)))

; 2.21
(define (square-list items)
  (if (null? items)
    items
    (cons (square (car items))
          (square-list (cdr items)))))

(define (square-list items)
  (map square items))

; 2.23
(define (for-each proc items)
  (cond ((null? items) #f)
        (else
          (proc (car items))
          (for-each proc (cdr items)))))
