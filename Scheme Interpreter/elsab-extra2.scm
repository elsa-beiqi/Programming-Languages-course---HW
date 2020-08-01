(define get-operator (lambda (op-symbol)
  (cond
    ((equal? op-symbol ’+) +)
    ((equal? op-symbol ’-) -)
    ((equal? op-symbol ’*) *)
    ((equal? op-symbol ’/) /)
    (else (error "s7-interpret: operator not implemented -->" op-symbol)))))

(define define-stmt? (lambda (e)
  (and (list? e) (equal? (car e) ’define) (symbol? (cadr e)) (= (length e) 3))))
  
  
  
  
(define letstar-stmt? (lambda (e)
	(and (list? e) (equal? (car e) 'let*) (= (length e) 3))))

(define let-stmt? (lambda (e)
	(and (list? e) (equal? (car e) 'let) (= (length e) 3))))
  
(define if-stmt? (lambda (e)
	(and (list? e) (equal? (car e) 'if)  (= (length e) 4))))
 
 

(define get-value (lambda (var env)
  (cond
    ((null? env) (error "s7-interpret: unbound variable -->" var))
    ((equal? (caar env) var) (cdar env))
    (else (get-value var (cdr env))))))

(define extend-env (lambda (var val old-env)
  (cons (cons var val) old-env)))

(define repl (lambda (env)
  (let* (
    (dummy1 (display "cs305> "))
    (expr (read))
    (new-env (if (define-stmt? expr)
        (extend-env (cadr expr) (s7-interpret (caddr expr) env) env)
         env))
    (val (if (define-stmt? expr)
        (cadr expr)
        (s7-interpret expr env)))
    (dummy2 (display "cs305: "))
    (dummy3 (display val))
    (dummy4 (newline))
    (dummy4 (newline)))
  (repl new-env))))
  
(define s7-interpret (lambda (e env)
  (cond
    ((number? e) e)
    ((symbol? e) (get-value e env))
    ((not (list? e)) (error "s7-interpret: cannot evaluate -->" e))
    (else
      (let ((operands (map s7-interpret (cdr e) (make-list (length (cdr e)) env)))
            (operator (get-operator (car e))))
        (apply operator operands))))))

(define cs305-interpreter (lambda () (repl ’())))