(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left  ; Left leaf
        right  ; Right leaf
        (append (symbols left) (symbols right))  ; symbols
        (+ (weight left) (weight right))))  ; sumf of weights

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
         (if (leaf? next-branch)
             (cons (symbol-leaf next-branch)
                   (decode-1 (cdr bits) tree))
             (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- chose-branch" bit))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))


(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; 記号
                               (cadr pair))  ; 頻度
                    (make-leaf-set (cdr pairs))))))
; gosh> (make-leaf-set '((A 1) (B 2) (C 1) (D 1)))
; ((leaf D 1) (leaf C 1) (leaf A 1) (leaf B 2))

; 2.67
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                    (make-leaf 'B 2)
                    (make-code-tree (make-leaf 'D 1)
                                    (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
; gosh> (decode sample-message sample-tree)
; (A D A B B C A)


; 2.68
(define (encode message tree)
  (if (null? message)
    '()
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (let ((left (left-branch tree))
        (right (right-branch tree)))
    (cond
      ((and (leaf? left)
            (eq? (symbol-leaf left) symbol))
       '(0))
      ((and (leaf? right)
            (eq? (symbol-leaf right) symbol))
       '(1))
      ((member symbol (symbols left))
       (cons 0 (encode-symbol symbol left)))
      ((member symbol (symbols right))
       (cons 1 (encode-symbol symbol right)))
      (else (error "bad symbol -- encode-symbol" symbol)))))

; 2.69
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (define (merge x xs)
    (if (null? xs)
      x
      (merge (make-code-tree (car xs) x)
             (cdr xs))))
  (merge (car leaf-set) (cdr leaf-set)))

; 2.70

; fixed bit: 3 * 35 = 105 bit
; Huffman: 87 bit
; gosh> (encode
;   '(GET A JOB SHA NA NA NA NA NA NA NA NA GET A JOB SHA NA NA NA NA NA NA NA NA WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP SHA BOOM)
;    (generate-huffman-tree '((A    2) (NA  16) (BOOM 1) (SHA  3) (GET  2) (YIP  9) (JOB  2) (WAH  1))))
; (1 1 1 1 0 1 1 1 0 1 1 1 1 1 0 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 0 1 1 1 0 1 1 1 1 1 0 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 0 1 1 1 1 1 1 0)
