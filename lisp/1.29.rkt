#lang racket
(define (sum-integers a b)
  (if (> a b)
      0
      (+ a (sum-integers (+ a 1) b))))


(define (sum-integers1 a b)
  (define (iter a b s)
  (if (= b a)
      (+ s a)
      (iter (+ a 1) b (+ s a))))
  (iter a b 0))


(define (cube a) (* a a a))

(define (sum-cubes a b)
  (if (> a b)
      0
      (+ (cube a) (sum-cubes (+ a 1) b))))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (inc a) (+ a 1))

(define (sum-cubes1 a b)
  (sum cube a inc b))

(define (identity x) x)
(define (sum-integers2 a b)
  (sum identity a inc b))





