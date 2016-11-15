#lang racket
; 2.36

(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (accumulate op initial (cdr seq)))))

(accumulate + 0 (list 1 2 3))

(define (accumulate-n op initial seq)
  (if (null? (car seq))
      null
      (cons (accumulate op initial (map car seq))
            (accumulate-n op initial (map cdr seq)))))

(accumulate-n +
              0
              (list (list 1 2 3)
                    (list 2 3 4)
                    (list 3 4 5)
                    (list 4 5 6)))


; 2.38
(accumulate / 1 (list 1 2 3))
(accumulate list null (list 1 2 3))

(define (fold-left op initial seq)
  (define (iter rest result)
    (if (null? rest)
        result
        (iter (cdr rest)
              (op result (car rest)))))
  (iter seq initial))

(fold-left + 0 (list 1 2 3))
(fold-left list null (list 1 2 3))

; op 必须参数顺序无关

; 2.39
(define (reverse seq)
  (accumulate (lambda (x y) (append y (list x))) null seq))

(reverse (list  1 2 3))

(define (reverse1 seq)
  (fold-left (lambda (x y) (cons y x)) null seq))

(reverse1 (list  1 2 3))

