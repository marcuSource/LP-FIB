;Aquest joc de proves serveix per comprovar que l'assignació de variables locals let siguin correctament interpretats


(define a 1)  ; Variable global
(define b 2)  ; Variable global
(define c 3)  ; Variable global

;Main

(define (main)
    ;Test bàsic amb una variable local nova
    (display "Test 1: let amb una variable local")
    (newline)
    (let ((d 5))
        (display (+ d 1)))                                               ; Resultat esperat: 6
    (newline)
    (newline)

    ;Test amb múltiples variables locals noves
    (display "Test 2: let amb múltiples variables locals")
    (newline)
    (let ((d 5)
          (e 3)
          (f 2))
        (display (* (+ d e) f)))                                         ; Resultat esperat: 16
    (newline)
    (newline)

    ;Test amb diferents tipus de dades
    (display "Test 3: let amb diferents tipus")
    (newline)
    (let ((num 42)
          (text "local")
          (valor #f)
          (lst '(4 5 6)))
        (display num) (display " ")                                      ; Resultat esperat: 42 local #f (4 5 6)
        (display text) (display " ")
        (display valor) (display " ")
        (display lst))
    (newline)
    (newline)

    ;Test amb let anidats amb noves variables
    (display "Test 4: let anidats")
    (newline)
    (let ((d 1))
        (let ((e 2))
            (let ((f 3))
                (display (+ d e f)))))                                   ; Resultat esperat: 6
    (newline)
    (newline)

    ;Test accedint a variables globals des de let
    (display "Test 5: let accedint a globals")
    (newline)
    (let ((d (+ a b))
          (e (* 2 c)))
        (display d) (display " ")                                        ; Resultat esperat: 3 6
        (display e))
    (newline)
)
