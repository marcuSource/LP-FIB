;Aquest joc de proves serveix per comprovar que els condicionals if i cond siguin correctament interpretats

(define num1 5)
(define num2 -3)
(define str1 "hola")
(define str2 "adeu")
(define bool1 #t)
(define bool2 #f)
(define llista1 '(1 2 3))
(define llista2 '(4 5))

;Main

(define (main)
   ;Tests if amb números
   (display "Test 1: if amb enters")
   (newline)
   (display (if (> num1 num2) "ordre correcte" "ordre incorrecte"))     ; Resultat esperat: ordre correcte
   (newline)
   (newline)

   ;Tests if amb strings
   (display "Test 2: if amb strings")
   (newline)
   (display (if (< str1 str2) "alfabètic" "no alfabètic"))              ; Resultat esperat: no alfabètic
   (newline)
   (newline)

   ;Tests if amb booleans
   (display "Test 3: if amb booleans")
   (newline)
   (display (if (and bool1 (not bool2)) "avaluació correcta" 
                                       "avaluació incorrecta"))         ; Resultat esperat: avaluació correcta
   (newline)
   (newline)

   ;Tests if amb llistes
   (display "Test 4: if amb llistes")
   (newline)
   (display (if (null? (cdr llista2)) "llista curta" "llista llarga"))  ; Resultat esperat: llista llarga
   (newline)
   (newline)

   ;Tests cond amb números
   (display "Test 5: cond amb enters")
   (newline)
   (display (cond 
       ((< num1 0) "negatiu")
       ((= num1 0) "zero")
       (else "positiu")))                                               ; Resultat esperat: positiu
   (newline)
   (newline)

   ;Tests cond amb strings
   (display "Test 6: cond amb strings")
   (newline)
   (display (cond
       ((= str1 "hola") "salutació")
       ((= str1 "adeu") "comiat")
       (else "altra cosa")))                                            ; Resultat esperat: salutació
   (newline)
   (newline)

   ;Tests cond amb booleans
   (display "Test 7: cond amb booleans")
   (newline)
   (display (cond
       ((and bool1 bool2) "ambdós certs")
       ((or bool1 bool2) "algun cert")
       (else "cap cert")))                                              ; Resultat esperat: algun cert
   (newline)
   (newline)

   ;Tests cond amb llistes
   (display "Test 8: cond amb llistes")
   (newline)
   (display (cond
       ((null? llista1) "buida")
       ((null? (cdr llista1)) "un element")
       (else "múltiples elements")))                                    ; Resultat esperat: múltiples elements
   (newline)
   (newline)

   ;Tests barrejant tipus
   (display "Test 9: if barrejant tipus")
   (newline)
   (display (if (or (> num1 0) bool1) 
               (if (= str1 "hola") "tot correcte" "string incorrecte")
               "condició falsa"))                                       ; Resultat esperat: tot correcte
   (newline)
   (newline)

   (display "Test 10: cond barrejant tipus")
   (newline)
   (display (cond
       ((null? llista1) "llista buida")
       ((not bool1) "bool1 fals")
       ((< str1 str2) "strings en ordre")
       (else "cap condició certa")))                                    ; Resultat esperat: cap condició certa
   (newline)
   )
