#lang racket


; 迭代版本
(define (filtered-accumulate combiner null-value predicate term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (if (predicate a)
                           (combiner (term a) result)
                           result))))
  (iter a null-value))

(define (great-than2? a) (> a 2))
(define (add a b) (+ a b))
(define (inc a) (+ a 1))
(define (id a) a)

; 过滤掉 < 2的所有元素
(filtered-accumulate add 0 great-than2? id 0 inc 10)