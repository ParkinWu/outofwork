#lang racket

; 2.4 下面是序对的另外一种过程性表示方式.请针对这一表示验证,对于
; 任意的x和y, (car (cons x y)) 都将产生出 x.
(define (cons x y)
  (lambda (m) (m x y)))
(define (car z)
  (z (lambda (p q) p)))
(define (cdr z)
  (z (lambda (p q) q)))

; 2.5 请证明, 如果将a和b的序对表示为乘积2^a*3^b对应的整数, 我们
; 就可以只用非负整数和算术运算表示序对. 请给出对应的过程cons, car
; 和cdr的定义.

; 2.6 如果觉得将序对表示为过程还不足以令人如雷灌顶, 那么请考虑, 在
; 一个可以对过程做各种操作的语言里, 我们完全可以没有数(至少在只考虑
; 非负整数的情况下), 可以将0和加一操作实现为:

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
