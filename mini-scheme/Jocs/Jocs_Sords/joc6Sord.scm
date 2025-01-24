;Aquest joc de proves implementa diversos algorismes per demostrar les capacitats de l'interpret



; ------------------- Funcions d'ordenació -------------------



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


; ------------------- Cerca Binària -------------------
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


; ------------------- Greedy -------------------
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


; ------------------- Test Principal -------------------

(define (main)
 ; Test Insertion Sort
 (display "Test Insertion Sort")
 (newline)
 (display "Input: (5 2 9 1 7 6 3)")
 (newline)
 (display "Output: ")
 (display (insertion-sort '(5 2 9 1 7 6 3)))				; Resultat esperat: (1 2 3 5 6 7 9)
 (newline)
 (newline)

 
 ; Test Merge Sort
 (display "Test Merge Sort")
 (newline)
 (display "Input: (5 2 9 1 7 6 3)")
 (newline)
 (display "Output: ")
 (display (merge-sort '(5 2 9 1 7 6 3)))				    ; Resultat esperat: (1 2 3 5 6 7 9)
 (newline)
 (newline)


 ; Test Binary Search
 (display "Test Binary Search")
 (newline)
 (display "Llista ordenada: (1 2 3 5 6 7 9)")
 (newline)
 (display "Cercant element 5: ")
 (newline)
 (binary-search '(1 2 3 5 6 7 9) 5)					        ; Resultat esperat: Element trobat: 5 a la posicio: 3
 (newline)
 (display "Cercant element 4: ")
 (newline)
 (binary-search '(1 2 3 5 6 7 9) 4)					        ; Resultat esperat: L'element no es troba a la llista
 (newline)
 (newline)

 
 ; Test Greedy
 (display "Test Greedy")
 (newline)
 (display "Pesos:      (2 3 4 5)")
 (newline)
 (display "Valors:     (3 4 5 6)")
 (newline)
 (display "Capacitat:  10")
 (newline)

 (let ((resultat (greedy-knapsack '(2 3 4 5) '(3 4 5 6) 10)))
   (display "Valor obtingut: ")
   (display (car resultat))						            ; Resultat esperat: Valor obtingut: 11
   (newline)
   (display "Objectes seleccionats (indexs): ")				; Resultat esperat: Objectes seleccionats (indexs): (2 3)
   (display (cdr resultat))
   (newline))
)
