(define nil '())
(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (square x) (* x x))
(define (find-divisor n test-diviser)
(cond ((> (square test-diviser) n) n)
      ((divides? test-diviser n) test-diviser)
      (else (find-divisor n (+ test-diviser 1)))))

(define (divides? a b)
  (= (remainder b a) 0))
(define (smallest-divisor n)
  (find-divisor n 2))
(define (prime? n)
  (= n (smallest-divisor n)))


; 2.33
; (define (map p sequence)
;     (accumulate (lambda (x y) (cons (p x) y)) nil sequence))
;
; (define (append seq1 seq2)
;   (accumulate cons seq1 seq2))
;
; (define (length sequence)
;   (accumulate (lambda (x y) (+ y 1)) 0 sequence))

; 2.34
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ (* x higher-terms)
                   this-coeff))
              0
              coefficient-sequence))


; 2.35
(define (count-leaves t)
  (accumulate +
              0
              (map (lambda (e)
                     (cond ((null? e) 0)
                           ((pair? e) (count-leaves e))
                           (else 1))) t)))

; 2.36
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
    nil
    (cons (accumulate op init (map car seqs))
          (accumulate-n op init (map cdr seqs)))))

; 2.37
(define (dot-product v w)
    (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
    (map (lambda (r) (dot-product r v)) m))

(define (transpose mat)
  (accumulate-n cons (list) mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (r) (matrix-*-vector cols r)) m)))

; 2.38
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest))
            (cdr rest))))
  (iter initial sequence))


; 2.39
(define (reverse sequence)
    (fold-right (lambda (x y) (append y (list x))) nil sequence))

(define (reverse sequence)
  (fold-left (lambda (x y) (cons y x)) nil sequence))

; 2.40
(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))


(define (enumerate-interval low high)
  (if (> low high)
    nil
    (cons low (enumerate-interval (+ low 1) high))))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap
                 (lambda (i)
                   (map (lambda (j) (list i j))
                        (enumerate-interval 1 (- i 1))))
                 (enumerate-interval 1 n)))))

(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence))


(define (permutations s)
  (if (null? s)
    (list nil)
    (flatmap (lambda (x)
               (map (lambda (p) (cons x p))
                    (permutations (remove x s))))
             s)))


(define (unique-pairs n)
    (flatmap
      (lambda (i)
        (map (lambda (j) (list i j))
             (enumerate-interval 1 (- i 1))))
      (enumerate-interval 1 n)))

; 2.41
(define (find-triples-equals-to-n n)
  (filter (lambda (l) (= n (accumulate + 0 l)))
          (map (lambda (i) (enumerate-interval i (+ i 2)))
       (enumerate-interval 1 (- n 2)))))
; (1 2 3) -> ((1, 1), (2, 1), (3, 1)) -> (1, 1, 2, 1, 3, 1)
; (display
;   (flatmap
;     (lambda (x) (list x 1))
;     (list 1 2 3)))

