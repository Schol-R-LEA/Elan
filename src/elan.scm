(define elan:repl
  (lambda ()
    (display "Elan test REPL")
    (let loop ((lexical-env '((parent ())))
               (applied-env '((parent ())))
      (display #\newline)
      (display #\newline)
      (display ">>> ")
      (let ((result (elan:eval (read) env)))
        (display (get-result-value result))
        (loop (get-new-lexical-env result) (get-new-applied-env result)))))


(define elan:eval
  (lambda (expr lexical-env applied-env)
    "Evaluator for a sub-set of Scheme."
    (if (atom? expr)
        (cond
         ((literal? expr lexical-env applied-env)
          (evaluation-result (literal->value expr lexical-env)
                             lexical-env applied-env))
         ((interned-symbol? expr lexical-env applied-env)
          (resolve-value (symbol->variable expr) lexical-env applied-env))
         (else (error "EVAL - could not evaluate atom")))
        (let* ((application (car expr))
               (args (cdr expr))
               (fn (if (applicable? application lexical-env applied-env)
                       application
                       (elan:eval application lexical-env applied-env))))
          (elan:apply fn args lexical-env applied-env))
           (else (error "EVAL  - could not evaluate list")))))))


(define elan:types '(elan:number elan:string elan:char
                                 elan:symbol
                                 elan:procdure elan:primitive elan:special-form))

(define make-arity-alist
  (lambda (args-list named-args-list var-arg)
    (list
     (list 'base-arity (length args-list))
     (list 'named-args named-args-list)
     (list 'var-arg var-arg))))

(define make-variable
  (lambda (type name value)
    (if (memq type elan:types)
        (list
         (list 'type type)
         (list 'name name)
         (list 'value value)))))
         

(define make-template
  (lambda (scaffold args-list named-args-list var-arg)
    (let ((interpolate
           (lambda (scaffold 

     

(define make-special-form
  (lambda (name scaffold args-list named-args-list var-arg)
    (make-variable 'elan:special
                   name
                   (make-template scaffold arg-list named-list var-arg)))

(define applicable?
  (lambda (expr lexical-env applied-env)
    (if  (interned-symbol? expr lexical-env applied-env)
         (let ((val (resolve-value (symbol->variable expr) lexical-env applied-env)))
           (case (get-value-type val)
             ('elan:special ())
             ('elan:primitive ())
             ('elan:procedure ())
             (else #f))))))


;;; utility functions used to shortcut frequently used idioms

(define value?
  (lambda (obj)
    (not (null? obj))))


(define atom?
  (lambda (expr)
    (not (pair? expr))))


(define make-env
  (lambda (parent)
    (list 'parent parent)))


(define make-value-record
  (lambda (name type value)
    (cons name 
    

;;; abstract handlers for different kinds of
;;; syntactics elements.
;;; For now, these are just a placeholders for
;;; functins which may need to be elaborated on later

(define evaluation-result list)

(define get-result-value car)

(define get-new-env cdr)

(define symbol->variable
  (lambda (sym)
    sym))      

(define interned-symbol? symbol?)

(define literal->value
  (lambda (atom)
    atom))


(define literal?
  (lambda (expr env)
    (or (number? expr)
        (string? expr)
        (char? expr))))


(define resolve-value
  (lambda (expr env)
    (let ((value (assoc env expr)))
      (if (null? value)
          (if (assoc 'parent env)
              (resolve-value expr (assoc 'parent env))
              (else (error "EVAL - symbol has no bound value.")))
          value))))

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


(elan:repl)
