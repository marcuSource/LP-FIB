# Scheme Interpreter

[Scheme](https://docs.scheme.org/) és un llenguatge de programació funcional, derivat de Lisp, conegut per la seva simplicitat i la seva estructura basada en expressions.

## Requisits

-  `Python 3`

-  `ANTLR4`

-  `antlr4-python3-runtime`

## Instal·lació

Abans que res s'ha de tenir instal·lat [Python 3](https://www.python.org/)
Un cop fet això cal instal·lar `ANTLR4`:

```bash
pip  install  antlr4-tools
antlr4

pip  install  antlr4-python3-runtime
```

En windows la instal·lació és diferent, veure: [Windows-Antlr4](https://github.com/antlr/antlr4-tools).

  

## Ús

Per fer anar el intèrpret de Scheme, genereu els arxius necessaris amb la comanda `make`.

  

Un cop generats els arxius, podeu executar qualsevol programa de Scheme amb l'extensió `.scm` amb aquesta comanda:

  

```bash
python3  scheme.py  nom_del_fitxer.scm
```

  

### Entrada/Sortida

A més a més l'interpret accepta l'ús de pipes d'entrada i sortida, el que fa que siguin possibles redirigir els inputs i outputs a fitxers de text:

  

```bash
python3  scheme.py  nom_del_fitxer.scm < entrada.txt > sortida.txt
```

  

**Important**: en els fitxers d'entrada, els inputs han d'estar separats per `\n`.

  

### Gestió d'Errors

L'intèrpret de Scheme identifica tots els errors sintàctics, però no errors semàntics ni de tipus.

  
  

## Funcionalitats

  

Aquest intèrpret accepta una versió minimalista de Scheme, i el que inclou l'intèrpret s'especifica en l'[enunciat de la pràctica](https://github.com/jordi-petit/lp-mini-scheme).

  

La sintaxis bàsica de Scheme segueix aquest patró:

  
```scheme
(funció arg1 arg2 ...)
```
  

Les expressions són llistes on el primer element és una funció i els següents elements són els arguments, sempre entre parèntesis.

  

El programa en Scheme comença per la definició de funcions i variables globals:

  

```scheme
(define x 35) ; Assigna permanentment el valor 35 a x

(define (suma a b) ; Declara i defineix la funció 'suma' que suma dos paràmetres
(+ a b)
)
```

  

Un cop totes les funcions i variables del programa han estat declarades es pot passar al `main`:

  

```scheme
(define (main)
;Cos del programa
)
```

Els comentaris en Scheme comencen per `;`.

  

### Tipus de Dades

- Enters.

- Strings.

- Booleans: `#t` i `#f`

- Llistes: `'(l1 l2 l3)`

  



### Operadors
**Aritmètics:** `+`, `-` , `*`, `/`. 

**Comparació:** `>`, `<`, `>=`, `<=`, `=`, `<>`  .

**Lògics:** `and`, `or`, `not`.

**Important**: Els operadors de comparació NO serveixen per les llistes.
  

#### Llistes

- Retornar el primer element d'una llista: `car`  .
	```scheme 
	(car (1 2 3 4)) ; Resultat: 1
	 ```

- Retornar la cua de la llista: `cdr` .
	```scheme 
	(cdr(1 2 3 4)) ; Resultat: (2 3 4)
	 ```

- Afegir un element al principi d'una llista: `cons` .
	```scheme 
	(cons 0 (1 2 3 4)) ; Resultat: (0 1 2 3 4)
	 ```

- Comprovar si una llista és buida: `null?`.
	```scheme 
	(null? (1 2 3 4)) ; Resultat: #f
	 ```

### Condicionals

#### If
L'estructura `if` avalua una condició i executa una expressió o una altra segons el resultat.

```scheme 
	(if (> 5 3)      ; Condició
    "És més gran"    ; Expressió si cert
    "És més petit")  ; Expressió si fals
```

#### Cond
L'estructura `cond` permet múltiples condicions i expressions associades.

```scheme 
(cond
    ((< n 0) "Negatiu")     ; Primera condició
    ((= n 0) "Zero")        ; Segona condició
    (else "Positiu"))       ; Cas per defecte
```

El cas per defecte ve definit per la paraula `else` i no accepta cap cas posterior en el cond, ja que sempre s'avalua com a certa. L'intèrpret permet substituir-la per `#t`:

```scheme 
(cond
    ((< n 0) "Negatiu")     ; Primera condició
    ((= n 0) "Zero")        ; Segona condició
    (#t "Positiu"))         ; Cas per defecte
```


### Variables Locals
El `let` permet definir variables locals que només existeixen dins del seu àmbit.

```scheme 
(let ((x 5)
      (y 3))
    (+ x y))     ; Les variables x i y només existeixen dins del let
```

### Entrada i Sortida

#### Lectura
`read`: Llegeix un valor de l'entrada estàndard.

```scheme 
(let ((x (read)))    ; Llegeix un valor i l'assigna a x
```

#### Escriptura
-   `display`: Mostra un valor per la sortida estàndard.
-   `newline`: Salta de línia.

```scheme 
(display "Hola")     ; Mostra "Hola"
(newline)            ; Salta de línia
```

### Funcions Recursives
L'interpret de scheme avaluara correctament funcions recursives.

```scheme 
(define (factorial n)
    (if (= n 0)
        1
        (* n (factorial (- n 1)))))
```

### Funcions d'Ordre Superior
L'interpret de scheme avaluara correctament funcions d'ordre superior.

```scheme 
(define (aplica-dos-cops f x)
    (f (f x)))       ; Aplica la funció f dues vegades a x
```

## Limitacions

-   **Tipus de dades**:
    -   No suporta números en coma flotant `float`, només enters.

-   **Funcions**:
    -   No inclou funcions de llibreria estàndard de Scheme.
    -   No permet funcions amb nombre variable d'arguments.
    -   No suporta funcions anònimes (`lambda`).

-   **Estructures de Control**:
    -   No implementa `do` ni `while`.
    -   No suporta `case`.
    -   No té `begin` per agrupar expressions.
 
-  **Gestió d'Errors**:
    -   No implementa gestió d'errors (`try-catch`).
    -   No fa comprovacions de tipus.
    -   Els errors d'execució tenen comportament indefinit.


## Jocs de Prova
Per comprovar el correcte funcionament de l'interpret s'han dissenyat diversos jocs de prova. Per simplicitat s'han agrupat en carpetes diferents i el seu contingut es pot executar amb els scripts `.sh` lliurats.

```bash
./nomfitxer.sh
```

Pot ser que no s'executi, si això passes, atribuiu-li el permis d'escriptura amb la comanda:

```bash
chmod +x nomfitxer.sh
```

El propòsit de cada joc de proces està descrit en el mateix codi del joc.

### Jocs sense Input
En la carpeta Jocs_Sords hi han 6 programes en scheme que comproven el correcte funcionament de l'interpret, des de les operacions bàsiques fins a algorismes més complexos.

Aquests jocs tenen la peculiaritat que no accepten cap input.

Per agilitzar el proces del testing, l'arxiu `scriptSord.sh` executa tots els jocs de prova i en guarda els fitxers de sortida a la mateixa carpeta Jocs_Sords amb l'extensió `.out`.

### Jocs amb Input
En la carpeta Jocs\_Read hi ha els mateixos 6 programes que en la carpeta Jocs\_Sords però aquests si accepten inputs. 

L'arxiu `scriptRead.sh` executarà cada joc de prova amb una serie de fitxers `.inp` ja definits en el directori i en guardarà la sortida en els corresponents fitxers `.out`.

### Jocs d'Error
Els jocs d'error es troben a la carpeta Jocs_Error i consta de 10 jocs amb errors sintàctics en programes de scheme. L'arxiu `scriptError.sh` executara els jocs i guardarà la sortida en un únic arxiu `sortida.out`.

## Autor 📄
**Marc Font I Cabarrocas**
[marc.font.cabarrocas@estudiantat.upc.edu](mailto:marc.font.cabarrocas@estudiantat.upc.edu)
