;Aquest joc de proves serveix per comprovar que la declaració i ús de funcions són correctament interpretades

(define suma 0)

;Funcions amb enters
(define (suma-tres a b c)
   (+ a b c))


;Funció amb booleans
(define (tots-certs a b c)
   (and (and a b) c))


;Funció amb strings
(define (concatena str1 str2)
   str1)   ; Retornem només un valor


;Funció amb llistes
(define (primer llista)
   (car llista))  ; Retornem només el primer


;Funció que combina if i cond
(define (evalua-nombre n)
   (if (< n 0)
       "negatiu"
       (cond 
           ((= n 0) "zero")
           ((< n 10) "petit")
           ((< n 100) "mitjà")
           (else "gran"))))


;Funció amb let i operacions
(define (sumar-dos-valors x y)
  (let ((val1 x)
        (val2 y))
     (display "La suma és: ")
     (display (+ val1 val2))
     (newline)))


;Main
(define (main)
   (display "Test 1: Funció amb enters")
   (newline)
   (display (suma-tres 1 2 3))                                         ; Resultat esperat: 6
   (newline)
   (newline)

   (display "Test 2: Funció amb booleans")
   (newline)
   (display (tots-certs #t #t #t))                                     ; Resultat esperat: #t
   (newline)
   (newline)

   (display "Test 3: Funció amb strings")
   (newline)
   (display (concatena "Hola " "món"))                                 ; Resultat esperat: Hola
   (newline)
   (newline)

   (display "Test 4: Funció amb llistes")
   (newline)
   (display (primer '(1 2 3)))                                 	       ; Resultat esperat: 1
   (newline)
   (newline)
   
   (display "Test 5: Funció amb if i cond")
   (newline)
   (display (evalua-nombre -5))                                        ; Resultat esperat: negatiu
   (newline)
   (display (evalua-nombre 0))                                         ; Resultat esperat: zero
   (newline)
   (display (evalua-nombre 5))                                         ; Resultat esperat: petit
   (newline)
   (display (evalua-nombre 50))                                        ; Resultat esperat: mitjà
   (newline)
   (display (evalua-nombre 500))                                       ; Resultat esperat: gran
   (newline)
   (newline)

   (display "Test 6: Funció amb let")
   (newline)
   (sumar-dos-valors 4 5)                                              ; Resultat esperat: 9
)
