; linear recursive process
(define (factorial n)
    (if (= n 1)
        1
        (* n (factorial (- n 1)))))


; (factorial 6)
; (* 6 (factorial 5))
; (* 6 (* 5 (factorial 4)))
; (* 6 (* 5 (* 4 (factorial 3))))
; (* 6 (* 5 (* 4 (* 3 (factorial 2)))))
; (* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))
; (* 6 (* 5 (* 4 (* 3 (* 2 1)))))
; (* 6 (* 5 (* 4 (* 3 2))))
; (* 6 (* 5 (* 4 6)))
; (* 6 (* 5 24))
; (* 6 120)
; 720


; iterative process
(define (factorial n)
  (define (iter product counter max-count)
    (if (> counter max-count)
      product
      (iter (* counter product)
            (+ counter 1)
            max-count)))
  (iter 1 1 n))


; (factorial 6)
; (iter   1 1 6)
; (iter   1 2 6)
; (iter   2 3 6)
; (iter   6 4 6)
; (iter  24 5 6)
; (iter 120 6 6)
; (iter 720 7 6)

; 1.9
(define (+ a b)
  (if (= a 0)
    b
    (inc (+ (dec a) b))))

; recursive
; (+ 4 5)
; (if (= 4 0)
;   5
;   (inc (+ (dec 4) 5)))
; (inc (+ (dec 4) 5))
; (inc (+ 3 5))
; (inc (inc (+ (dec 3) 5)))
; (inc (inc (+ 2 5)))
; (inc (inc (inc (+ (dec 2) 5))))
; (inc (inc (inc (+ 1 5))))
; (inc (inc (inc (inc (+ (dec 1) 5)))))
; (inc (inc (inc (inc (+ 0 5)))))
; (inc (inc (inc (inc 5))))
; (inc (inc (inc 6)))
; (inc (inc 7))
; (inc 8)
; 9

(define (+ a b)
  (if (= a 0)
    b
    (+ (dec a) (inc b))))

; iterative
; (+ 4 5)
; (if (= 4 0)
;   5
;   (+ (dec 4) (inc 5)))
; (+ 3 5))
; (+ (dec 3) (inc 5)))
; (+ 2 6)
; (+ (dec 2) (inc 6)))
; (+ 1 7)
; (+ (dec 1) (inc 8)))
; (+ 0 9)
; 9

; 1.10
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))
; (A 1 10)
; (cond ((= y 0) 0)
;       ((= x 0) (* 2 y))
;       ((= y 1) 2)
;       (else (A (- x 1)
;                (A x (- y 1)))))
; (A (- 1 1) (A 1 (- 10 1)))
; (A 0 (A 1 9))
; (A 0 (A (- 1 1) (A 1 (- 9 1))))
; (A 0 (A 0 (A 1 8)))
; (A 0 (A 0 (A 0 (A 1 7))))
; (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 7 1))))))
; (A 0 (A 0 (A 0 (A 0 (A 1 6)))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))
; (A 0 (A 0 (A 0 (A 0 (A 0 32)))))
; (A 0 (A 0 (A 0 (A 0 64))))
; (A 0 (A 0 (A 0 128)))
; (A 0 (A 0 256))
; (A 0 512)
; 1024
;
; (A 2 4)
; (A 1 (A 2 3))
; (A 1 (A 1 (A 2 2)))
; (A 1 (A 1 (A 1 (A 2 1))))
; (A 1 (A 1 (A 1 2)))
; (A 1 (A 1 (A 0 (A 1 1))))
; (A 1 (A 1 (A 0 2)))
; (A 1 (A 1 4))
; (A 1 (A 0 (A 1 3)))
; (A 1 (A 0 (A 0 (A 1 2))))
; (A 1 (A 0 (A 0 (A 0 (A 1 1)))))
; (A 1 (A 0 (A 0 (A 0 2))))
; (A 1 (A 0 (A 0 4)))
; (A 1 (A 0 8))
; (A 1 16)
; (A 0 (A 1 15))
; (A 0 (A 0 (A 1 14)))
; (A 0 (A 0 (A 0 (A 1 13))))
; (A 0 (A 0 (A 0 (A 0 (A 1 12)))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 11))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 10)))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 9))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 8)))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 7))))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 6)))))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 32)))))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 64))))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 128)))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 256))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 512)))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 1024))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 2048)))))
; (A 0 (A 0 (A 0 (A 0 4096))))
; (A 0 (A 0 (A 0 8192)))
; (A 0 (A 0 16384))
; (A 0 32768)
; 65536
;
; (A 3 3)
; (A 2 (A 3 3))
; (A 2 (A 2 (A 3 2)))
; (A 2 (A 2 (A 2 (A 3 1))))
; (A 2 (A 2 (A 2 2)))
; (A 2 (A 2 (A 1 (A 2 2))))
; (A 2 (A 2 (A 1 2)))
; (A 2 (A 2 (A 0 (A 1 1))))
; (A 2 (A 2 (A 0 2)))
; (A 2 (A 2 4))
; (A 2 (A 1 (A 2 3)))
; (A 2 (A 1 (A 1 (A 2 2))))
; (A 2 (A 1 (A 1 2)))
; (A 2 (A 1 (A 0 (A 1 1))))
; (A 2 (A 1 (A 0 2)))
; (A 2 (A 1 2))
; (A 2 (A 0 (A 1 1)))
; (A 2 (A 0 2))
; (A 2 4) ; = 65536
; 65536

; (define (f n) (* 2 n))
(define (f n) (A 0 n))
; (define (g n) (expt 2 n))
(define (g n) (A 1 n))
; (define (expt 2 (expt 2 n)))
(define (h n) (A 2 n))
