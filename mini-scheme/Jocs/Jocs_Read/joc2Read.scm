;Aquest joc de proves serveix per comprovar que els condicionals if i cond siguin correctament interpretats
;També comprova que les expressions s'avaluin de forma correcta amb els read


;Variables globals numèriques
(define num1 5)
(define num2 -3)

;Variables globals strings
(define str1 "hola")
(define str2 "adeu")

;Variables globals booleanes
(define bool1 #t)
(define bool2 #f)

;Variables globals llistes
(define llista1 '(1 2 3))
(define llista2 '(4 5))


;Main

(define (main)
   ;Tests if amb números
   (display "Test 1: if amb enters")
   (newline)
   (display "num1 = 5")
   (newline)
   (display "Introdueix un número per comparar amb num1: ")
   (let ((num (read)))
        (display (if (> num1 num) "num1 és més gran" "num1 és més petit o igual"))
        (newline)
        (newline))
   
   ;Tests if amb strings
   (display "Test 2: if amb strings")
   (newline)
   (display "str1 = hola")
   (newline)
   (display "Introdueix un string per comparar amb str1: ")
   (let ((str (read)))
        (display (if (< str1 str) "str1 va primer" "str1 va després o és igual"))
        (newline)
        (newline))
   
   ;Tests if amb booleans
   (display "Test 3: if amb booleans")
   (newline)
   (display "bool1 = #t")
   (newline)
   (display "Introdueix un booleà (1 per true, 0 per false): ")
   (let ((bool (read)))
        (display (if (and bool1 (= bool 1)) "tots dos certs" "algun fals"))
        (newline)
        (newline))
   
   ;Tests if amb llistes
   (display "Test 4: if amb llistes")
   (newline)
   (display "llista1 = (1 2 3)")
   (newline)
   (display "Comprovem si el primer element és més gran que un valor donat")
   (newline)
   (display "Introdueix un número per comparar amb el primer element: ")
   (let ((num (read)))
        (display (if (> (car llista1) num) "primer element més gran" "primer element més petit o igual"))
        (newline)
        (newline))

   ;Tests cond amb números
   (display "Test 5: cond amb enters")
   (newline)
   (display "Introdueix un número per classificar-lo: ")
   (let ((num (read)))
        (display (cond 
            ((< num 0) "negatiu")
            ((= num 0) "zero")
            (else "positiu")))
        (newline)
        (newline))

   ;Tests cond amb strings
   (display "Test 6: cond amb strings")
   (newline)
   (display "Introdueix un string (hola o adeu): ")
   (let ((str (read)))
        (display (cond
            ((= str "hola") "salutació")
            ((= str "adeu") "comiat")
            (else "altra cosa")))
        (newline)
        (newline))

   ;Tests cond amb booleans
   (display "Test 7: cond amb booleans")
   (newline)
   (display "bool1 = #t")
   (newline)
   (display "Introdueix un booleà (1 per true, 0 per false): ")
   (let ((bool (read)))
        (display (cond
            ((and bool1 (= bool 1)) "ambdós certs")
            ((or bool1 (= bool 1)) "algun cert")
            (else "cap cert")))
        (newline)
        (newline))

   ;Tests cond amb llistes
   (display "Test 8: cond amb llistes")
   (newline)
   (display "llista2 = (4 5)")
   (newline)
   (display "Introdueix un número per comparar amb tots els elements: ")
   (let ((num (read)))
        (display (cond
            ((> num (car llista2)) "més gran que el primer")
            ((> num (car (cdr llista2))) "més gran que el segon")
            (else "més petit que tots")))
        (newline)
        (newline))

   ;Tests barrejant tipus
   (display "Test 9: if barrejant tipus")
   (newline)
   (display "num1 = 5, str1 = hola")
   (newline)
   (display "Introdueix un número: ")
   (let ((num (read)))
        (display (if (or (> num1 num) bool1) 
                    (if (= str1 "hola") "tot correcte" "string incorrecte")
                    "condició falsa")))
   (newline)
   (newline)

   (display "Test 10: cond barrejant tipus")
   (newline)
   (display "Introdueix un booleà (1 per true, 0 per false): ")
   (let ((bool (read)))
        (display (cond
            ((null? llista1) "llista buida")
            ((= bool 1) "booleà cert")
            ((< str1 str2) "strings en ordre")
            (else "cap condició certa")))
        (newline)))
