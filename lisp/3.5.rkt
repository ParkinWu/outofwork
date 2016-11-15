#lang racket
(require racket/stream)

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (less5? x) (< x 5))
(stream-filter less5? integers)

(define (div? x y) (= (remainder x y) 0))
(define no-sevens
  (stream-filter (lambda (x) (not (div? x 7)))
                 integers))

(stream-ref no-sevens 7)

(define odd-integers
  (stream-filter odd? integers))

(stream-first (stream-rest odd-integers))

