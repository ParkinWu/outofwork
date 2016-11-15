#lang racket
(define (add-rat x y)
  (make-rat (+ (* (number x) (denom y))
               (* (number y) (denom x)))
            (* (denom x) (denom y))))

; 序对
(define (make-rat x y) (cons x y))
(define (number x) (car x))
(define (denom x) (cdr x))

(define x (cons 1 2))
(define y (cons 2 3))

(define (print-rat x)
  (newline)
  (display (number x))
  (display "/")
  (display (denom x)))

(print-rat (add-rat x y))

; 练习2.1
; 定义出make-rat的一个更好的版本,使之可以正确处理整数和负数.
; 当有理数为正时, make-rat 应当将其规范化, 使它的分子和分母都是正的.
; 如果有理数为负, 那么就应该只让分子为负
(define (abs x)
  (cond ((< x 0) (- x))
        ((= x 0) 0)
        ((> x 0) x)))

(define (better-make-rat x y)
  (if (< (* x y) 0)
      (cons (- 0 (abs x)) (abs y))
      (cons (abs x) (abs y))))

; 练习2.2
; 请考虑平面上线段的表示问题. 一个线段用一对点表示, 他们分别是线段的起始点和终点
; 请定义构造函数 make-segment和选择函数 start-segment, end-segment, 他们
; 基于点定义线段表示. 进而一个点可以用数的序对表示, 分别表示x坐标和y坐标. 请进一
; 步给出构造函数make-point 和 选择函数 x-point, y-point, 用他们定义出点的这
; 种表示. 最后定义出 midpoint-segment, 它以一个线段为参数, 返回线段的中点, 为了
; 实验这些过程,还需要定义一种打印点的方法:
(define (print-point p)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (make-point x y)
  (cons x y))
(define (x-point p)
  (car p))
(define (y-point p)
  (cdr p))

(define (make-segment sp ep)
  (cons sp ep))
(define (start-segment seg)
  (car seg))
(define (end-segment seg)
  (cdr seg))

(define (print-segment seg)
  (newline)
  (print-point (start-segment seg))
  (display "-")
  (print-point (end-segment seg)))


(define sp (make-point 1 2))
(define ep (make-point 2 5))

(define seg (make-segment sp ep))

(print-segment seg)




