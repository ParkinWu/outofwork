#lang racket
(require racket/stream)

(define (fold-right op init seq)
  (define (iter a result)
    (if (null? a)
        result
        (iter (cdr a)
              (op (car a)
                  result))))
  (iter seq init))

(define (enumerate-interval a b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (+ a 1) (cons a result))))
  (iter a null))

(define (sum-oddes a b)
  (fold-right +
              0
              (filter odd? (enumerate-interval a b))))

;(car (cdr (filter odd? (enumerate-interval 10000 10000000))))



(define (enumerate-interval-stream a b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (+ a 1) (stream-cons a result))))
  (iter a empty-stream))



(define (filter-stream f seq)
  (define (iter a result)
    (if (stream-empty? a)
        result
        (if (f (stream-first a))
            (iter (stream-rest a) (stream-cons (stream-first a) result))
            (iter (stream-rest a) result))))
  (iter seq empty-stream))

;(car (cdr (filter odd? (enumerate-interval 1 8000000))))
(stream-first (stream-rest
             (stream-filter odd?
                            (enumerate-interval-stream 1 9000000))))
