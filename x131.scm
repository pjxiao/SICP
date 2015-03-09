(define (cube x) (* x x x))

(define (inc x) (+ x 1))

(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
       (sum term (next a) next b))))


(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))


; 1.29
(define (simpson f a b n)
  (define h
    (/ (- b a) n))
  (define (y k)
    (f (+ a (* k h))))
  (define (term i)
    (if (even? i)
      (* 2 (y i))
      (* 4 (y i))))
  (* (/ h 3.0)
     (+ (y 0)
        (sum term a inc (- n 1))
        (y n))))

; 1.30
(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
       (sum term (next a) next b))))

; 1.31a
(define (product term a next b)
  (if (> a b)
    1
    (* (term a)
       (product term (next a) next b))))

(define (factorial a)
  (define (next i) (+ i 1))
  (define (term i) i)
  (product term 1 next a))

(define (pi n)
  (define (next i) (+ i 1))
  (define (term k)
    (if (even? k)
      (/ (+ 2 k) (+ 1 k))
      (/ (+ 1 k) (+ 2 k))))
  (* 4.0 (product term 1 next n)))

; 1.31b
(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (* (term a) result))))
  (iter a 1))

(define (factorial-iter a)
  (define (next i) (+ i 1))
  (define (term i) i)
  (product-iter term 1 next a))


; 1.32a
(define (accumulate combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner (term a)
              (accumulate combiner null-value term (next a) next b))))

(define (sum-acc term a next b)
  (accumulate + 0 term a next b))

(define (product-acc term a next b)
  (accumulate * 1 term a next b))


; 1.32a
(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (combiner (term a) result))))
  (iter a null-value))

; 1.33a
(define (filtered-accumulate combiner null-value term a next b predicate)
  (cond ((> a b) null-value)
        ((predicate a)
         (combiner
           (term a)
           (accumulate combiner null-value term (next a) next b)))
        (else (accumulate combiner null-value term (next a) next b))))

; 1.33b
(define (filtered-accumulate-iter combiner null-value term a next b predicate)
  (define (iter a result)
    (cond ((> a b) result)
          ((predicate a)
           (iter (next a)
                 (combiner (term a) result))))
          (else (iter (next a) result)))
  (iter a null-value))
