;Aquest joc de proves serveix per comprovar que els tipus de dades son correctament interpretats i que les operacions definides funcionen correctament.
;També comprova que les expressions s'avaluin de forma correcta amb els read


;Main

;Variables globals numèriques
(define x 1)
(define y -2)
(define z 3)

;Variables globals booleanes
(define True #t)
(define False #f)

;Variables globals strings
(define a "head")
(define b "shoulders")
(define c "knees")
(define d "toes")

;Variables globals llistes
(define intL '(1 2 3 4))
(define strL '("head" "shoulders" "knees" "toes"))
(define listL '(intL strL))

(define (main)
    ;OPERACIONS NUMÈRIQUES
    (display "OPERACIONS NUMÈRIQUES:")
    (newline)
    (newline)
    
    ;Suma amb x
    (display "x = 1")
    (newline)
    (display "Introdueix un nombre per sumar amb x: ")
    (let ((num (read)))
        (display "x + ")
        (display num)
        (display " = ")
        (display (+ x num))
        (newline)
        (newline))
    
    ;Resta amb z
    (display "z = 3")
    (newline)
    (display "Introdueix un nombre per restar-li z: ")
    (let ((num (read)))
        (display num)
        (display " - z = ")
        (display (- num z))
        (newline)
        (newline))
    
    ;Multiplicació amb y
    (display "y = -2")
    (newline)
    (display "Introdueix un nombre per multiplicar amb y: ")
    (let ((num (read)))
        (display "y * ")
        (display num)
        (display " = ")
        (display (* y num))
        (newline)
        (newline))
    
    ;Divisió amb x
    (display "x = 1")
    (newline)
    (display "Introdueix un nombre per dividir-lo per x: ")
    (let ((num (read)))
        (display num)
        (display " / x = ")
        (display (/ num x))
        (newline)
        (newline))

    ;Operació combinada numèrica
    (display "y = -2, x = 1")
    (newline)
    (display "Introdueix un nombre n per calcular (n + y) * x: ")
    (let ((n (read)))
        (display "(")
        (display n)
        (display " + y) * x = ")
        (display (* (+ n y) x))
        (newline)
        (newline))

    ;OPERACIONS BOOLEANES
    (display "OPERACIONS BOOLEANES:")
    (newline)
    (display "True = #t (introdueix 1)")
    (newline)
    (display "False = #f (introdueix 0)")
    (newline)
    (newline)

    ;AND amb True
    (display "Introdueix un booleà (1 per true, 0 per false) per fer AND amb True: ")
    (let ((bool (read)))
        (display "True AND ")
        (display bool)
        (display " = ")
        (display (and True (= bool 1)))
        (newline)
        (newline))

    ;OR amb False
    (display "Introdueix un booleà (1 per true, 0 per false) per fer OR amb False: ")
    (let ((bool (read)))
        (display "False OR ")
        (display bool)
        (display " = ")
        (display (or False (= bool 1)))
        (newline)
        (newline))

    ;NOT
    (display "Introdueix un booleà (1 per true, 0 per false) per fer-li NOT: ")
    (let ((bool (read)))
        (display "NOT ")
        (display bool)
        (display " = ")
        (display (not (= bool 1)))
        (newline)
        (newline))

    ;Operació complexa booleana
    (display "Operació complexa: (not read1) and (True or (not read2))")
    (newline)
    (display "Introdueix el primer booleà (1 per true, 0 per false) (read1): ")
    (let ((bool1 (read)))
        (display "Introdueix el segon booleà (1 per true, 0 per false) (read2): ")
        (let ((bool2 (read)))
            (display "(not ")
            (display bool1)
            (display ") and (True or (not ")
            (display bool2)
            (display ")) = ")
            (display (and (not (= bool1 1)) (or True (not (= bool2 1)))))
            (newline)
            (newline)))

    ;OPERACIONS AMB STRINGS
    (display "OPERACIONS AMB STRINGS:")
    (newline)
    (display "a = head")
    (newline)
    (display "b = shoulders")
    (newline)
    (display "c = knees")
    (newline)
    (display "d = toes")
    (newline)
    (newline)

    ;Comparació d'igualtat (=)
    (display "Comprovem igualtat (=)")
    (newline)
    (display "Introdueix un string per comparar amb a (head): ")
    (let ((str (read)))
        (display str)
        (display " = a és ")
        (display (= str a))
        (newline)
        (newline))

    ;Comparació de diferència (<>)
    (display "Comprovem diferència (<>)")
    (newline)
    (display "Introdueix un string per comparar amb b (shoulders): ")
    (let ((str (read)))
        (display str)
        (display " <> b és ")
        (display (<> str b))
        (newline)
        (newline))

    ;Comparació menor que (<)
    (display "Comprovem menor que (<)")
    (newline)
    (display "Introdueix un string per comparar amb c (knees): ")
    (let ((str (read)))
        (display str)
        (display " < c és ")
        (display (< str c))
        (newline)
        (newline))

    ;Comparació major que (>)
    (display "Comprovem major que (>)")
    (newline)
    (display "Introdueix un string per comparar amb d (toes): ")
    (let ((str (read)))
        (display str)
        (display " > d és ")
        (display (> str d))
        (newline)
        (newline))

    ;Comparació menor o igual (<=)
    (display "Comprovem menor o igual (<=)")
    (newline)
    (display "Introdueix un string per comparar amb a (head): ")
    (let ((str (read)))
        (display str)
        (display " <= a és ")
        (display (<= str a))
        (newline)
        (newline))

    ;Comparació major o igual (>=)
    (display "Comprovem major o igual (>=)")
    (newline)
    (display "Introdueix un string per comparar amb b (shoulders): ")
    (let ((str (read)))
        (display str)
        (display " >= b és ")
        (display (>= str b))
        (newline)
        (newline))

    ;OPERACIONS AMB LLISTES
    (display "OPERACIONS AMB LLISTES:")
    (newline)
    (display "intL = (1 2 3 4)")
    (newline)
    (display "strL = (head shoulders knees toes)")
    (newline)
    (display "listL = (intL strL)")
    (newline)
    (newline)

    ;Car de intL
    (display "Car de intL: ")
    (display (car intL))
    (newline)
    (newline)

    ;Cdr de strL
    (display "Cdr de strL: ")
    (display (cdr strL))
    (newline)
    (newline)

    ;Cons amb strL i listL
    (display "Cons de strL i listL: ")
    (display (cons strL listL))
    (newline)
    (newline)

    ;Null? de listL
    (display "listL és buida? ")
    (display (null? listL))
    (newline))
