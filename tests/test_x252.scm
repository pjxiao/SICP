(load "./x252.scm")

(display
    ((lambda ()
       (list
            'coercion
            (lambda (put-coercion
              'scheme-number 'scheme-number
              (lambda (x) x)))
            (eq? ((get-coercion 'scheme-number 'scheme-number) 1) 1)
       )
   ))
)

(display
    ((lambda ()
       (list
            '2.81
            (install-scheme-number-package)
            (install-rectangular-package)
            (install-complex-package)
            (eq? (exp 1 2) 1)
            (eq? 'aaa 'aaa)
            ; (exp  ; this causes infinite loop or fail
            ;     (make-complex-from-real-imag 1 1)
            ;     (make-complex-from-real-imag 1 1))
       )
   ))
)
