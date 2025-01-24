;Aquest joc de proves serveix per comprovar que l'interpret executa bé les funcions recursives i d'ordre superior
;També comprova que les expressions s'avaluin de forma correcta amb els read

;Funcions recursives i d'ordre superior
(define (factorial n)
    (if (= n 0)
        1
        (* n (factorial (- n 1)))))

(define (fibonacci n)
    (if (< n 2)
        n
        (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))

(define (ordenada? lst)
    (if (null? lst)
        #t
        (if (null? (cdr lst))
            #t
            (if (> (car lst) (car (cdr lst)))
                #f
                (ordenada? (cdr lst))))))

(define (map-custom f lst)
    (if (null? lst)
        '()
        (cons (f (car lst)) (map-custom f (cdr lst)))))

(define (filter-custom pred lst)
    (if (null? lst)
        '()
        (if (pred (car lst))
            (cons (car lst) (filter-custom pred (cdr lst)))
            (filter-custom pred (cdr lst)))))

(define (range n)
    (range-aux 1 n))

(define (range-aux start end)
    (if (> start end)
        '()
        (cons start (range-aux (+ start 1) end))))

(define (double x)
    (* x 2))

(define (parell x)
    (= 0 (- x (* (/ x 2) 2))))

(define (sum lst)
    (if (null? lst)
        0
        (+ (car lst) (sum (cdr lst)))))

(define (concat str n)
    (if (= n 0)
        '()
        (cons str (concat str (- n 1)))))

;Main

(define (main)
    ;Test factorial
    (display "Test factorial(n)")
    (newline)
    (display "Calcula el factorial d'un nombre")
    (newline)
    (display "Introdueix n: ")
    (let ((n (read)))
        (display "factorial(")
        (display n)
        (display ") = ")
        (display (factorial n)))
    (newline)
    (newline)

    ;Test fibonacci
    (display "Test fibonacci(n)")
    (newline)
    (display "Calcula el n-èsim número de Fibonacci")
    (newline)
    (display "Introdueix n: ")
    (let ((n (read)))
        (display "fibonacci(")
        (display n)
        (display ") = ")
        (display (fibonacci n)))
    (newline)
    (newline)

    ;Test sum i range
    (display "Test suma dels números de l'1 fins a n")
    (newline)
    (display "Introdueix n: ")
    (let ((n (read)))
        (display "sum(range(")
        (display n)
        (display ")) = ")
        (display (sum (range n))))
    (newline)
    (newline)

    ;Test map-custom amb double
    (display "Test duplicar els números de l'1 fins a n")
    (newline)
    (display "Introdueix n: ")
    (let ((n (read)))
        (display "map-custom(double, range(")
        (display n)
        (display ")) = ")
        (display (map-custom double (range n))))
    (newline)
    (newline)

    ;Test filter-custom amb parell
    (display "Test filtrar números parells de l'1 fins a n")
    (newline)
    (display "Introdueix n: ")
    (let ((n (read)))
        (display "filter-custom(parell, range(")
        (display n)
        (display ")) = ")
        (display (filter-custom parell (range n))))
    (newline)
    (newline)

    ;Test ordenada amb una llista de tres elements
    (display "Test ordenada?(llista)")
    (newline)
    (display "Introdueix tres números per crear una llista")
    (newline)
    (display "n1: ")
    (let ((n1 (read)))
        (display "n2: ")
        (let ((n2 (read)))
            (display "n3: ")
            (let ((n3 (read)))
                (let ((llista (cons n1 (cons n2 (cons n3 '())))))
                    (display "ordenada?(")
                    (display llista)
                    (display ") = ")
                    (display (ordenada? llista))))))
    (newline)
    (newline)

    ;Test concat
    (display "Test concat(str,n)")
    (newline)
    (display "Introdueix un string: ")
    (let ((str (read)))
        (display "Quantes vegades el vols repetir? ")
        (let ((n (read)))
            (display "concat(")
            (display str)
            (display ",")
            (display n)
            (display ") = ")
            (display (concat str n))))
    (newline))
