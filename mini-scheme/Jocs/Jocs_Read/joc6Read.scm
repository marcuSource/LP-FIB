;Aquest joc de proves implementa diversos algorismes per demostrar les capacitats de l'interpret


;Funcions d'ordenació i altres algorismes

; Insertion Sort 
(define (insertion-sort lst)
 (if (null? lst)
     '()
     (insert (car lst) (insertion-sort (cdr lst)))))

(define (insert x lst)
 (if (null? lst)
     (cons x '())
     (if (< x (car lst))
         (cons x lst)
         (cons (car lst) (insert x (cdr lst))))))

; Merge Sort amb split combinat
(define (split lst)
 (if (null? lst)
     (cons '() '())
     (if (null? (cdr lst))
         (cons lst '())
         (let ((rec (split (cdr (cdr lst)))))
           (cons (cons (car lst) (car rec))
                (cons (car (cdr lst)) (cdr rec)))))))

(define (merge-sort lst)
 (if (null? lst)
     '()
     (if (null? (cdr lst))
         lst
         (let ((halves (split lst)))
           (merge (merge-sort (car halves))
                 (merge-sort (cdr halves)))))))

(define (merge l1 l2)
 (if (null? l1)
     l2
     (if (null? l2)
         l1
         (if (< (car l1) (car l2))
             (cons (car l1) (merge (cdr l1) l2))
             (cons (car l2) (merge l1 (cdr l2)))))))

; Binary Search
(define (binary-search lst x)
 (binary-search-aux lst x 0))

(define (binary-search-aux lst x pos)
 (if (null? lst)
     (display "L'element no es troba a la llista")
     (if (= (car lst) x)
         (let ((result (cons x pos)))
           (display "Element trobat: ")
           (display (car result))
           (display " a la posicio: ")
           (display (cdr result))
           result)
         (if (< x (car lst))
             (display "L'element no es troba a la llista")
             (binary-search-aux (cdr lst) x (+ pos 1))))))

; Greedy Knapsack
(define (make-item w v i)
 (cons w (cons v (cons i '()))))

(define (get-weight item)
 (car item))

(define (get-value item)
 (car (cdr item)))

(define (get-index item)
 (car (cdr (cdr item))))

(define (get-ratio item)
 (/ (get-value item) (get-weight item)))

(define (sort-by-ratio items)
 (if (null? items)
     '()
     (insert-by-ratio (car items) (sort-by-ratio (cdr items)))))

(define (insert-by-ratio x lst)
 (if (null? lst)
     (cons x '())
     (if (> (get-ratio x) (get-ratio (car lst)))
         (cons x lst)
         (cons (car lst) (insert-by-ratio x (cdr lst))))))

(define (make-items weights values idx)
 (if (null? weights)
     '()
     (cons (make-item (car weights) (car values) idx)
           (make-items (cdr weights) (cdr values) (+ idx 1)))))

(define (greedy-knapsack weights values capacity)
 (greedy-aux (sort-by-ratio (make-items weights values 0)) capacity 0 '()))

(define (greedy-aux items capacity total selected)
 (if (null? items)
     (cons total selected)
     (if (>= capacity (get-weight (car items)))
         (greedy-aux (cdr items) 
                    (- capacity (get-weight (car items)))
                    (+ total (get-value (car items)))
                    (cons (get-index (car items)) selected))
         (greedy-aux (cdr items) capacity total selected))))

; Funció auxiliar per llegir n valors
(define (llegir-n-valors n llista tipus)
    (if (= n 0)
        llista
        (let ((aux (display tipus)))
            (let ((aux (display " objecte ")))
                (let ((aux (display n)))
                    (let ((aux (display ": ")))
                        (let ((val (read)))
                            (llegir-n-valors (- n 1) (cons val llista) tipus)))))))) 

;Main

(define (main)
 ;Test Insertion Sort
 (display "Test Insertion Sort")
 (newline)
 (display "Introdueix 4 números per ordenar:")
 (newline)
 (display "n1: ")
 (let ((n1 (read)))
     (display "n2: ")
     (let ((n2 (read)))
         (display "n3: ")
         (let ((n3 (read)))
             (display "n4: ")
             (let ((n4 (read)))
                 (let ((llista (cons n1 (cons n2 (cons n3 (cons n4 '()))))))
                     (display "Input: ")
                     (display llista)
                     (newline)
                     (display "Output ordenat: ")
                     (display (insertion-sort llista))
                     (newline)
                     (newline))))))

 ;Test Merge Sort
 (display "Test Merge Sort")
 (newline)
 (display "Introdueix 4 números diferents per ordenar:")
 (newline)
 (display "n1: ")
 (let ((n1 (read)))
     (display "n2: ")
     (let ((n2 (read)))
         (display "n3: ")
         (let ((n3 (read)))
             (display "n4: ")
             (let ((n4 (read)))
                 (let ((llista (cons n1 (cons n2 (cons n3 (cons n4 '()))))))
                     (display "Input: ")
                     (display llista)
                     (newline)
                     (display "Output ordenat: ")
                     (display (merge-sort llista))
                     (newline)
                     (newline))))))

 ;Test Binary Search
 (display "Test Binary Search")
 (newline)
 (display "Usarem la llista ordenada (1 2 3 4 5 6 7)")
 (newline)
 (display "Quin número vols buscar? ")
 (let ((x (read)))
     (display "Cercant element ")
     (display x)
     (display ": ")
     (newline)
     (binary-search '(1 2 3 4 5 6 7) x))
 (newline)
 (newline)

 ;Test Greedy Knapsack
 (display "Test Greedy Knapsack")
 (newline)
 (display "Quants objectes vols introduir? ")
 (let ((n (read)))
     (let ((pesos '()) (valors '()))
         ;Llegim els pesos
         (display "Introdueix els pesos dels objectes:")
         (newline)
         (let ((pesos (llegir-n-valors n '() "pes")))
             ;Llegim els valors
             (display "Introdueix els valors dels objectes:")
             (newline)
             (let ((valors (llegir-n-valors n '() "valor")))
                 (display "Introdueix la capacitat de la motxilla: ")
                 (let ((cap (read)))
                     (display "Pesos:  ")
                     (display pesos)
                     (newline)
                     (display "Valors: ")
                     (display valors)
                     (newline)
                     (display "Capacitat: ")
                     (display cap)
                     (newline)
                     (let ((resultat (greedy-knapsack pesos valors cap)))
                         (display "Valor màxim obtingut: ")
                         (display (car resultat))
                         (newline)
                         (display "Objectes seleccionats (índexs): ")
                         (display (cdr resultat))
                         (newline))))))))
