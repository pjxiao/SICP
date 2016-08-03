(require "./Gauche-compat-sicp/compat/sicp.scm")
(import compat.sicp)
(require "./common.scm")
(import common)
(load "./x251.scm")


(define (put-coercion type1 type2 op)
  (put 'coercion (list type1 type2) op))

(define (get-coercion type1 type2)
  (get 'coercion (list type1 type2)))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (if (= (length args) 2)
          (let ((type1 (car type-tags))
                (type2 (cadr type-tags))
                (a1 (car args))
                (a2 (cadr args)))
            (if (eq? type1 type2)
              (error "No method for these types"
                     (list op type-tags))
              (let ((t1->t2 (get-coercion type1 type2))
                    (t2->t1 (get-coercion type2 type1)))
                (cond (t1->t2 (apply-generic op (t1->t2 a1) a2))
                      (t2->t1 (apply-generic op a1 (t2->t1 a2)))
                      (else (error "No method for these types"
                                   (list op type-tags)))))))
          (error "No method for these types"
                 (list op type-tags)))))))


(define (scheme-number->complex n)
  (make-complex-from-real-imag (contents n) 0))
(define (scheme-number->scheme-number n) n)
(define (complex-complex z) z)

; 2.81
(put-coercion 'scheme-number 'complex scheme-number->complex)
(put-coercion 'scheme-number 'scheme-number scheme-number->scheme-number)
(put-coercion 'complex 'complex complex-complex)
(define (exp x y) (apply-generic 'exp x y))
