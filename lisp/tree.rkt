#lang racket
(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

; (define x (list 1 (list 2 (list 3 4))))

; 2.25 给出能够从下列各表中取出7的car和cdr组合
; (1 3 (5 7) 9)
; ((7))
; (1 (2 (3 (4 (5 (6 7))))))

; 2.26 假定 x y
(define x (list 1 2 3))
(define y (list 4 5 6))
; 解释器对于下面各个表达式将打印出什么结果:
; (1 2 3 4 5 6), 两个列表组合成一个
(append x y)
; ((1 2 3) 4 5 6), 给y 添加一个列表元素
(cons x y)
; 两个列表组成一个新列表
(list x y)

; 2.27 修改reverse, 得到一个deep-reverse过程. 所有元素都翻转, 包括子树

(define (deep-reverser l)
  ((deep-reverser (car l))
   (deep-reverser (cdr l))))

(define text-reverser (list (list 1 2) (list 3 4)))




