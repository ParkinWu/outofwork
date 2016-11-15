#lang racket
(define (min x y)
  (cond ((< x y) x)
        ((= x y) x)
        ((> x y) y)))
(min 10 10)
(min 5 10)
(min 10 5)

(define (max-sum x y z)
  (- (+ x y z) (min (min x y) z)))

(max-sum 2 2 3)
(max-sum 3 1 10)
(max-sum -10 1 2)