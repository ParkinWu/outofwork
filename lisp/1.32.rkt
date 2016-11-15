#lang racket
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))
(define (sum-recruit term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum-recruit term (next a) next b))))

(define (inc a) (+ a 1))
(define (identity a) a)

; accumulate 递归版本
(define (accumulate-recruit combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate-recruit combiner null-value term (next a) next b))))
; accumulate 迭代版本
(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))


(define (add a b) (+ a b))
(define (product a b) (* a b))
; (new-sum-recruit 1 1000000000) 可以正常运行
(define (new-sum b e)
  (accumulate add 0 identity b inc e))
;(new-sum-recruit 1 1000000000) 内存耗尽
(define (new-sum-recruit b e)
  (accumulate-recruit add 0 identity b inc e))
; product 迭代版本
(define (new-product b e)
  (accumulate product 1 identity b inc e))

