;Aquest joc de proves serveix per comprovar que els tipus de dades son correctament interpretats i que les operacions definides funcionen correctament.

;Assignació de variables int
(define x 10)
(define y -1)
(define z 33)

;Assignació de variables bool
(define True #t)
(define False #f)

;Assignació de variables string
(define a "head")
(define b "shoulders")
(define c "knees")
(define d "toes")

;Assignació de variables list
(define intL '(1 2 3 4))
(define boolL '(True #f #t #t))
(define stringL '(a b c d))
(define listL '(intL boolL stringL))


;Main

(define (main)
    ;Operacions amb int
    
    (display "Test d'operacions + - * /")
    (newline)
    
    (display (+ x y))                                           ; Resultat esperat: 9
    (newline)
    (display (- z y))                                           ; Resultat esperat: 34
    (newline)
    (display (* x y z))                                         ; Resultat esperat: -330
    (newline)
    (display (/ z 11))                                          ; Resultat esperat: 3
    (newline)
    (display (* (+ x y 11) (- 1 2) (/ (+ 5 5) (- 4 2))))        ; Resultat esperat: -100
    (newline)
    (display (/ -10 3))                                         ; Resultat esperat: -3
    (newline)
    (display (/ 1 1))                                           ; Resultat esperat: 1
    (newline)
    (newline)
    
    ;Operacions amb bool
    
    (display "Test d'operacions and or not")
    (newline)
    
    (display (and True True))                                   ; Resultat esperat: #t
    (newline)
    (display (and True #f))                                     ; Resultat esperat: #f
    (newline)
    (display (or True False))                                   ; Resultat esperat: #t
    (newline)
    (display (or #f True))                                      ; Resultat esperat: #t
    (newline)
    (display (not True))                                        ; Resultat esperat: #f
    (newline)
    (display (not #f))                                          ; Resultat esperat: #t
    (newline)
    (display (or (not #t) (and (not False) True)))              ; Resultat esperat: #t
    (newline)
    (display (and (>= x y) (< y z)))                            ; Resultat esperat: #t
    (newline)
    (newline)
    
    ;Operacions amb string
    
    (display "Test d'operacions = <> < <= > >=")
    (newline)
    
    (display a)                                                 ; Resultat esperat: head
    (newline)
    (display a) (display " ") (display b) (display " ")
    (display c) (display " and ") (display d)                   ; Resultat esperat: head shoulders knees and toes
    (newline)
    (display (= a b))                                           ; Resultat esperat: #f
    (newline)
    (display (= "shoulders" b))                                 ; Resultat esperat: #t
    (newline)
    (display (<> "abracadabra" b))                              ; Resultat esperat: #t
    (newline)
    (display (> "a" b))                                         ; Resultat esperat: #f
    (newline)
    (display (< "a" b))                                         ; Resultat esperat: #t
    (newline)
    (display (>= "a" ""))                                       ; Resultat esperat: #t
    (newline)
    (display (<= "a" ""))                                       ; Resultat esperat: #f
    (newline)
    (display (= "" ""))                                         ; Resultat esperat: #t
    (newline)
    (display (<> "" " "))                                       ; Resultat esperat: #t
    (newline)
    (newline)
    
    ;Operacions amb list
    
    (display "Test d'operacions car cdr cons null?")
    (newline)
    
    (display boolL)                                             ; Resultat esperat: (#t #f #t #t)
    (newline)
    (display (cdr stringL))                                     ; Resultat esperat: (shoulders knees toes)
    (newline)
    (display (car listL))                                       ; Resultat esperat: (1 2 3 4)
    (newline)
    (display (cons 0 intL))                                     ; Resultat esperat: (0 1 2 3 4)
    (newline)
    (display (null? boolL))                                     ; Resultat esperat: #f              
    (newline)
    (display (= (car (car listL)) (car intL)))                  ; Resultat esperat: #t
    (newline)
    (display (car (cdr listL)))                                 ; Resultat esperat: (#t #f #t #t)
    (newline)
    (display (null? '()))                                       ; Resultat esperat: #t
    (newline)
    (display (cons 1 '()))                                      ; Resultat esperat: (1)
    (newline)
  
)



