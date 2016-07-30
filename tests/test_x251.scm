(load "./x251.scm")

(display
    ((lambda ()
       (list
            'scheme-number
            (install-scheme-number-package)
            (eq? (=zero? 0) #t)
            (eq? (=zero? 1) #f)
       )
   ))
)

(display
    ((lambda ()
       (list
            'rational
            (install-rational-package)
            (eq? (=zero? (make-rational 1 1)) #f)
            (eq? (=zero? (make-rational 0 1)) #t)
       )
   ))
)

(display
    ((lambda ()
       (list
            'complex
            (install-rectangular-package)
            (install-polar-package)
            (install-complex-package)
            (eq? (=zero? (make-complex-from-real-imag 1 0)) #f)
            (eq? (=zero? (make-complex-from-real-imag 0 1)) #f)
            (eq? (=zero? (make-complex-from-real-imag 0 0)) #t)
            (eq? (=zero? (make-complex-from-mag-ang 1 0)) #f)
            (eq? (=zero? (make-complex-from-mag-ang 0 1)) #f)
            (eq? (=zero? (make-complex-from-mag-ang 0 0)) #t)
       )
   ))
)
