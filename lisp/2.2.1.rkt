#lang racket

; 序列

(cons 1
      (cons 2
            (cons 3
                  (cons 4 1))))

(define (list-ref l n)
  (if (= n 0)
      (car l)
      (list-ref (cdr l) (- n 1))))

(define squares (list 1 4 9 16 25))

(list-ref squares 3)

(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))

(define (length1 items)
  (define (length-iter a count)
    (if (null? a)
        count
        (length-iter (cdr a) (+ 1 count))))
  (length-iter items 0))

; 2.17 请定义出过程last-pair, 它返回只包含给定(非空)表里最后一个元素的表:
(define (last-pair items)
  (if (null? (cdr items))
      (car items)
      (last-pair (cdr items))))

; 2.18 请定义出过程reverse, 它以一个表为参数,返回的表中包含的元素与参数表相同,
; 但排列顺序与参数表相反:

(define (reverse items)
  (define (reverse-iter a res)
    (if (null? a)
        res
        (reverse-iter (cdr a)
                      (cons (car a) res))))
  (reverse-iter items null))




