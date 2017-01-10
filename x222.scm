(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))


; 2.25
(car (cdr (car (cdr (cdr (list 1 3 (list 5 7) 9))))))
(car (car (list (list 7))))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7))))))))))))))))))

; 2.26
(define x (list 1 2 3))
(define y (list 4 5 6))

; (1 2 3 4 5 6)
(append x y)

; ((1 2 3) 4 5 6)
(cons x y)

; ((1 2 3) (4 5 6))
(list x y)

; 2.27
(define x (list (list 1 2) (list 3 4)))

(define (deep-reverse items)
  (define (iter a reversed)
    (if (null? a)
      reversed
      (iter (cdr a) (cons (car a) reversed))))
  (iter items (list)))


; http://rskmt.hateblo.jp/entry/20090523/1243086189
(define (deep-reverse items)
  (if (pair? items)
    (append (deep-reverse (cdr items)) (list (deep-reverse (car items))))
    items))
(define (deep-reverse items)
  (if (pair? items)
    (reverse (map deep-reverse items))
    items))

; 2.28
(define (fringe items)
  (cond
    ((null? items) (list))
    ((pair? items)
     (append (fringe (car items)) (fringe (cdr items))))
    (else (list items))))

(define (fringe items)
  (cond
    ((null? items) (list))
    ((pair? items)
     (append (fringe (car items)) (fringe (cdr items))))
    (else (list items))))

(define x (list (list 1 2) (list 3 4)))

; 2.29
(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define left-branch  car)
(define right-branch cdr)

(define branch-length    car)
(define branch-structure cdr)

(define mobile? pair?)

(define (branch-weigth branch)
    (let ((structure (branch-structure branch)))
      (if (mobile? structure)
        (+ (branch-weigth (left-branch structure))
           (branch-weigth (right-branch structure))))))

(define (total-weigth mobile)
  (+ (branch-weigth (left-branch mobile))
     (branch-weigth (right-branch mobile))))

(define (balance mobile)
  (= (branch-weigth (left-branch mobile))
     (branch-weigth (right-branch mobile))))

(define (scale-tree tree factor)
  (cond ((null? tree) (list))
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))

(define (scale-tree tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
           (scale-tree sub-tree factor)
           (* sub-tree factor)))
       tree))


; 2.30
(define (square x) (* x x))

(define (square-tree tree)
  (cond ((null? tree) (list))
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                       (square-tree (cdr tree))))))

(define (square-tree tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
           (square-tree sub-tree)
           (square tree)))
       tree))

; 2.31
(define (tree-map procedure tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
           (tree-map procedure sub-tree)
           (procedure sub-tree)))
       tree))

; 2.32
(define (subsets s)
  (if (null? s)
    (list s)
    (let ((rest (subsets (cdr s))))
      (append rest (map (lambda (x) (cons (car s) x)) rest)))))
