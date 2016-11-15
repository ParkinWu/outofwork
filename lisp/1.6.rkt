#lang racket
(define (square x)
  (* x x))

(define (good-enough? guess x)
  (< (abs (- x (square guess))) 0.001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))
(define (improve guess x)
  (aver (/ x guess) guess))

(define (aver x y)
  (/ (+ x y) 2))
(define (sqrt x)
  (sqrt-iter 1.0 x))


(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (sqrt-iter1 guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter1 (improve guess x)
                      x)))

(define (sqrt1 x)
  (sqrt-iter1 1.0 x))

(sqrt1 10)


