#lang racket

;迭代版本
; (define (product term a next b)
;   (define (iter a result)
;     (if (> a b)
;         result
;         (iter (next a) (* (term a) result))))
;   (iter a 1)

; 递归版本
(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))

(define (identity a) a)
(define (inc-2 a) (+ a 2))

(define (product2 a b)
  (product identity a inc-2 b))

(define (square a) (* a a))

(define (num n)
  (/ (* (product2 2 n)
     (product2 4 n))
     n))
(define (deno n)
  (square (product2 3 n)))

(define (pi n)
  (* 4 (/ (num n) (deno n))))
