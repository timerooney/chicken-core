(import (chicken time))
(: deprecated-foo deprecated)
(define deprecated-foo 1)
(: deprecated-foo2 (deprecated foo))
(define deprecated-foo2 2)
(: foo boolean)
(define foo #t)

(define (r-proc-call-argument-count-mismatch) (cons '()))
(define (r-proc-call-argument-type-mismatch) (length 'symbol))
(define (r-proc-call-argument-value-count) (list (cpu-time)) (vector (values)) ((values)))
(define (r-cond-branch-value-count-mismatch) (if (the * 1) 1 (values 1 2)))
(define (r-invalid-called-procedure-type) (1 2))
(define (r-pred-call-always-true) (list? '()))
(define (r-pred-call-always-false) (symbol? 1))
(define (r-cond-test-always-true) (if 'symbol 1))
(define (r-cond-test-always-false) (if #f 1))
(define (r-type-mismatch-in-the) (the symbol 1))
(define (r-zero-values-for-the) (the symbol (values)))
(define (r-too-many-values-for-the) (the symbol (values 1 2)))
(define (r-toplevel-var-assignment-type-mismatch) (set! foo 1))
(define (r-deprecated-identifier) (list deprecated-foo) (vector deprecated-foo2))

(set! foo 1)

(define (list-ref-negative-index) (list-ref '() -1))
(define (list-ref-out-of-range) (list-ref '() 1))
(define (append-invalid-last-arg) (scheme#append (list 1) 1)) ;; TODO: doesn't work
(define (vector-ref-out-of-range) (vector-ref (vector) -1))
(define (zero-values-for-let) (let ((a (values))) a))
(define (multiple-values-for-let) (let ((a (values 1 2))) a))
(define (zero-values-for-conditional) (if (values) 1))
(define (multiple-values-for-conditional) (if (values 1 2) 1))

;; (define (fail-compiler-typecase) (compiler-typecase 1 (symbol 1) (list 2)))

(module
 m
 ()
 (import scheme)
 (import (chicken base) (chicken type) (chicken time))

 (: foo2 boolean)
 (define foo2 #t)
 (: deprecated-foo deprecated)
 (define deprecated-foo 1)
 (: deprecated-foo2 (deprecated foo))
 (define deprecated-foo2 2)

 (define (toplevel-foo)
   (define (local-bar)
     (define (r-proc-call-argument-count-mismatch) (cons '()))
     (define (r-proc-call-argument-type-mismatch) (length 'symbol))
     (define (r-proc-call-argument-value-count) (list (cpu-time)) (vector (values)) ((values)))
     (define (r-cond-branch-value-count-mismatch) (if (the * 1) 1 (cpu-time)))
     (define (r-invalid-called-procedure-type) (1 2))
     (define (r-pred-call-always-true) (list? '()))
     (define (r-pred-call-always-false) (symbol? 1))
     (define (r-cond-test-always-true) (if (length '()) 1))
     (define (r-cond-test-always-false) (if #f 1))
     (define (r-type-mismatch-in-the) (the symbol 1))
     (define (r-zero-values-for-the) (the symbol (values)))
     (define (r-too-many-values-for-the) (the symbol (values 1 2)))
     (define (r-toplevel-var-assignment-type-mismatch) (set! foo2 1))
     (define (r-deprecated-identifier) (list deprecated-foo) (vector deprecated-foo2))

     (define (list-ref-negative-index) (list-ref '() -1))
     (define (list-ref-out-of-range) (list-ref '() 1))
     (define (append-invalid-last-arg) (scheme#append (list 1) 1)) ;; TODO: doesn't work
     (define (vector-ref-out-of-range) (vector-ref (vector) -1))
     (define (zero-values-for-let) (let ((a (values))) a))
     (define (multiple-values-for-let) (let ((a (values 1 2))) a))
     (define (zero-values-for-conditional) (if (values) 1))
     (define (multiple-values-for-conditional) (if (values 1 2) 1))

     (define (fail-compiler-typecase) (compiler-typecase 1 (symbol 1) (list 2)))
     )))