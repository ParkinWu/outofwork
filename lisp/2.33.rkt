#lang racket
; 2.33

(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (accumulate op initial (cdr seq)))))
(define (map p seq)
  (accumulate (lambda (x y) (cons (p x) y))
              null
              seq))

(define (append seq1 seq2)
  (accumulate cons
              seq2
              seq1))

(define (length seq)
  (accumulate +
              0
              (map (lambda (x) 1) seq)))

; 2.35 将count-leaves 重新定义为一个累积:

(define (count-leaves tree)
  (accumulate + 0 (map (lambda (x) (count-leaves x)) tree)))

