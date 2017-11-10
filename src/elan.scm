(define repl
  (lambda ()
    (display "Elan test REPL")
    (let loop ((env '((parent ()))))
      (display #\newline)
      (display #\newline)
      (display ">>> ")
      (let ((result (elan:eval (read) env)))
        (display (car result))
        (loop (cdr result))))))

(define atom?
  (lambda (expr)
    (not
     (or
      (null? expr)
      (pair? expr)))))

(define make-env
  (lambda (parent)
    (list 'parent parent)))

(define (elan:eval expr env)
  "Evaluator for a sub-set of Scheme."
  (cond
   ((atom? expr)
    (cond ((self-evaluating? expr env)
           (list expr env))
          (else (error "EVAL - could not evaluate atom"))))
   ((pair? expr)
    (error "EVAL  - could not evaluate list"))
   (else (error "EVAL  - could not evaluate expression"))))


(define self-evaluating?
  (lambda (expr env)
    (or (number? expr)
        (string? expr)
        (char? expr))))

(define id
  (lambda (expr env)
    (cond
     (((assoc? expr env)
       (assq env expr))
      ((not (null? (assoc? 'parent env)))
       (id expr (assq 'parent env)))
      (else (error "EVAL - symbol has no bound value."))))))

(define lexer-expansion?
  (lambda (arg-list env)
    #f))

(define expand-read-macro
  (lambda (arg-list env)
    #f))

(define parser-expansion?
  (lambda (arg-list env)
    #f))

(define expand-macro
  (lambda (arg-list env)
    #f))

(define variable?
  (lambda (arg-list env)
    #f))

(define get-value
  (lambda (arg-list env)
    #f))

(define quoted?
  (lambda (expr env)
    (symbol? expr)))

(define get-quoted-expr
  (lambda (arg-list env)
    #f))

(define quasiquoted?
  (lambda (arg-list env)
    #f))

(define get-qq-expr
  (lambda (arg-list env)
    #f))

(define spliced?
  (lambda (arg-list)
    #f))

(define get-spliced-value
  (lambda (arg-list env)
    #f))

(define assignment?
  (lambda (arg-list env)
    #f))

(define rebind
  (lambda (arg-list)
    #f))

(define simple-conditional?
  (lambda (arg-list)
    #f))

(define select
  (lambda (arg-list)
    #f))

(define complex-conditional?
  (lambda (arg-list)
    #f))

(define multi-select
  (lambda (arg-list)
    #f))

(define case-conditional?
  (lambda (arg-list)
    #f))

(define case-select
  (lambda (arg-list)
    #f))

(define match-conditional?
  (lambda (arg-list)
    #f))

(define domain-select  
  (lambda (arg-list)
    #f))

(define lambda?
  (lambda (arg-list)
    #f))

(define make-procedure
  (lambda (arg-list)
    #f))

(define scoped-procedure?
  (lambda (arg-list)
    #f))

(define apply-procedure
  (lambda (arg-list)
    #f))

(define empty-handler
  (lambda (args-list)
    'NO-MATCH))

(define valid?
  (lambda (result)
    (not (equal? result 'NO-MATCH))))


(define atom-eval-dispatch-table
  '((self-evaluating? id)
    (quoted? get-quoted-expr)
    (quasiquoted? get-qq-expr)
    (spliced? get-spliced-value)))  

(define special-form-dispatch-table
  '((assignment? rebind)
    (simple-conditional? select)
    (complex-conditional? multi-select)
    (case-conditional? case-select)
    (match-conditional? domain-select)
    (lambda? make-procedure)
    (scoped-procedure? apply-procedure)))


(repl)
