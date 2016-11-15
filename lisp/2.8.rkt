#lang racket
(define (make-interval a b) (cons a b))
(define (upper-bound x) (car x))
(define (lower-bound x) (cdr x))
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval a b)
  (make-interval (- (lower-bound a) (upper-bound b))
                 (- (upper-bound a) (lower-bound b))))

; 2.9 区间的宽度就是其上界和下界之差的一半. 区间宽度是有关区间所描述的相应
; 数值的非确定性的一种度量. 对于某些算数运算, 两个区间的组合结果的宽度就是
; 参数区间的宽度的函数, 而对于其他运算, 组合区间的宽度则不是参数区间宽度的函数
; 证明两个区间的和(与差)的宽度就是被加(或减)的区间的宽度的函数. 举例说明, 对于
; 乘和除而言,情况并非如此.

(define (width-interval x)
  (/ (- (upper-bound x) (lower-bound x))
     2))

; 2.12

