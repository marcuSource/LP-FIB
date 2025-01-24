;Aquest joc de proves serveix per comprovar que l'interpret executa bé les funcions recursives i d'ordre superior

; Funció recursiva factorial
(define (factorial n)
(if (= n 0)
    1
    (* n (factorial (- n 1)))))

; Funció fibonacci
(define (fibonacci n)
(if (< n 2)
    n
    (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))

; Comprovar si una llista està ordenada
(define (ordenada? lst)
(if (null? lst)
    #t
    (if (null? (cdr lst))
        #t
        (if (> (car lst) (car (cdr lst)))
            #f
            (ordenada? (cdr lst))))))

; Funció map
(define (map-custom f lst)
(if (null? lst)
    '()
    (cons (f (car lst)) (map-custom f (cdr lst)))))

; Funció d'ordre superior: filtra elements segons un predicat
(define (filter-custom pred lst)
(if (null? lst)
    '()
    (if (pred (car lst))
        (cons (car lst) (filter-custom pred (cdr lst)))
        (filter-custom pred (cdr lst)))))

; Funció range
(define (range n)
 (range-aux 1 n))

(define (range-aux start end)
 (if (> start end)
     '()
     (cons start (range-aux (+ start 1) end))))

; Funció auxiliar per duplicar un número
(define (double x)
(* x 2))

; Funció auxiliar per comprovar si un número és parell
(define (parell x)
 (= 0 (- x (* (/ x 2) 2))))
 
; Funció per sumar elements d'una llista
(define (sum lst)
(if (null? lst)
    0
    (+ (car lst) (sum (cdr lst)))))

; Funció recursiva per concatenar strings
(define (concat str n)
 (if (= n 0)
     '()
     (cons str (concat str (- n 1)))))

;Main

(define (main)
; Test factorial
(display "Test factorial 5: ")
(display (factorial 5))                                        ;Resultat esperat: 120
(newline)
(newline)

; Test fibonacci
(display "Fibonacci de 7: ")
(display (fibonacci 7))                                        ;Resultat esperat: 13
(newline)
(newline)

; Test range i sum
(display "Suma dels números de l'1 al 5: ")
(display (sum (range 5)))                                      ;Resultat esperat: 15
(newline)
(newline)

; Test map-custom amb double
(display "Duplicar els números de l'1 al 4: ")
(display (map-custom double (range 4)))                        ;Resultat esperat: (2 4 6 8)
(newline)
(newline)

; Test filter-custom amb parell
(display "Filtrar parells de l'1 al 6: ")
(display (filter-custom parell (range 6)))                     ;Resultat esperat: (2 4 6)
(newline)
(newline)

; Test ordenada
(display "Llista (1 2 3) està ordenada?: ")
(display (ordenada? '(1 2 3)))                                  ;Resultat esperat: #t
(newline)
(display "Llista (3 2 1) està ordenada?: ")
(display (ordenada? '(3 2 1)))                                  ;Resultat esperat: #f
(newline)
(newline)

; Test concat (strings)
(display "Concatenar 'hola' 3 cops: ")
(display (concat "hola" 3))                                    ;Resultat esperat: (hola hola hola)
(newline)
)
