#lang racket


(define-syntax delay
  (syntax-rules ()
    ((delay expr)
     (lambda ()
       (expr)))))

(define-syntax stream-cons
  (syntax-rules ()
    ((stream-cons a b)
     (cons a (delay b)))))


(define (force delay-object)
  (delay-object))

(define (integers-from-n x)
  (stream-cons x (integers-from-n (+ x 1))))

(define integers (integers-from-n 1))

