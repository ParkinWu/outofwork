#lang racket
(define (map proc items)
  (if (null? items)
      null
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (map1 proc items)
  (define (map-iter a result)
    (if (null? a)
        result
        (map-iter (cdr a)
                  (cons (proc (car a))
                        result))))
  (reverse (map-iter items null)))

(map1 (lambda (x) (* x 2)) (list 1 2 3 4))
; 2.21过程 square-list以一个数值表为参数, 返回每个数的平方构成的表:
(define (square-list l)
  (map1 (lambda (x) (* x x))
        l))

(square-list (list 1 2 3 4))

(define x (cons (list 1 2) (list 3)))



