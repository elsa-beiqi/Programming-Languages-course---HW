(define symbol-length
  (lambda (inSym)
    (if (symbol? inSym)
      (string-length (symbol->string inSym))
      0
    )
  )
)

(define (is-symbol-1 thing)
  (and (symbol? thing)
       (= 1 (string-length (symbol->string thing))))
       
(define (sequence? list)
  (or (null? list)                     ;; #t if list is empty
      (and (is-symbol-1 (car list))    ;; first element is-symbol-1
           (sequence?   (cdr list))))) ;; and rest is sequence? too
           
           
(define same-sequence?
  (lambda (and inSeq1 inSeq2)
    (if(and(sequence? inSeq1) (sequence? inSeq2) (eq? inSeq1 inSeq2))
      #t
    )
    (else if(and(sequence? inSeq1) (sequence? inSeq2) (not(eq? inSeq1 inSeq2)))
      #f
    )
    (else
      (error: "Error")
    )
  )
)

(define (reverse-sequence inSeq)
  (if (not (sequence? inSeq))
      '()  ; can't reverse if it's not a sequence
      (let loop ((inSeq inSeq)
                 (reversed '()))
        (if (null? inSeq)
            reversed
            (loop (cdr inSeq) (cons (car inSeq) reversed))))))
            
            
(define (palindrome inSeq)
  (if (not (sequence? inSeq))
      #f
      (eq? inSeq (reverse-sequence inSeq))))         
      

(define member
  (lambda (and inSym inSeq)
    (if(and (sequence? inSeq) (symbol? inSym) eq?(inSeq? inSym))
      #t
    ) 
    (else if (and (sequence? inSeq) (symbol? inSym) not(eq?(inSeq? inSym)))
      #f
    )
    (else
      (error "Error")
    )
  )
)      

(define remove-member
  (lambda (and inSym inSeq2)
    (if (and symbol? inSym sequence? inSeq)
      inSeq
      (error "Error")
    )
  )
)

(define anagram?
  (lambda (and inSeq1 inSeq2)
    if(and(sequence? inSeq1) (sequence? inSeq2) anagram? (inSeq1 inSeq2))
      #t
    )
    else if(and(sequence? inSeq1) (sequence? inSeq2) not(anagram? (inSeq1 inSeq2)))
      #f
    )
    else(
      (error "Error")
    )
  )
)

(define anapoli?
  (lambda (and inSeq1 inSeq2)
    if(or(not(sequence? inSeq1)(not(sequence? inSeq2))))
      (error "Error")
    )
    else if(and(sequence? inSeq1) (sequence? inSeq2))
      if(and(palindrome? inSeq2)(anagram? inSeq2))
        #t
      )
      #f
    )
  )
)