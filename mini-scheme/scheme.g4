grammar scheme;

// Root Rule
root : defines main EOF;

// Separate rule for defines
defines : define* ;

// Define rule
define 
    : '(' 'define' '(' VAR VAR* ')' expression+ ')'    # defineFunction
    | '(' 'define' VAR expression ')'                 # defineConstant
    ;

// Main function rule
main : '(' 'define' '(' 'main' ')' expression+ ')' ;

// Expression Rules
expression
    : '(' operator expression+ ')'                    # operation
    | '(' 'if' expression expression expression ')'   # ifExpr
    | '(' 'cond' condClause+ ')'                      # condExpr
    | '(' 'let' '(' binding+ ')' expression+ ')'      # letExpr
    | '\'' expression                                 # quotedExpr
    | '(' ')'                                         # emptyList
    | '(' expression+ ')'                             # list
    | NUM                                             # number
    | BOOL                                            # boolean
    | STRING                                          # string
    | VAR                                             # variable
    | '(' 'display' expression ')'                    # displayExpr
    | '(' 'newline' ')'                               # newlineExpr
    ;

// Conditional Clause for `cond`
condClause : '(' expression expression ')' ;

binding
    : '(' VAR expression ')'                          # normalBinding
    | '(' VAR '(' 'read' ')' ')'                      # readBinding
    ;

// Tokens
NUM     : '-'? [0-9]+ ;                               // Numbers: Ints
BOOL    : '#t' | '#f' ;                               // Booleans: True/False
STRING  : '"' (~["\r\n])* '"' ;                       // String literals
VAR     : [a-zA-Z][a-zA-Z0-9+\-*/<>=?!]* ;            // Variables and identifiers

// Operators
operator
    : ARITH
    | COMPA
    | LOGOP
    | LISTOP
    | VAR ;

// Specific Operator Types
ARITH   : '+' | '-' | '*' | '/' ;                      // Arithmetic Operators
COMPA   : '=' | '<' | '>' | '<=' | '>=' | '<>' ;       // Comparison Operators
LOGOP   : 'and' | 'or' | 'not' ;                       // Logical Operators
LISTOP  : 'car' | 'cdr' | 'cons' | 'null?' ;           // List Operators

// Ignored Input
COMMENT : ';' ~[\r\n]* -> skip ;                       // Single-line Comments
WS      : [ \t\n\r]+ -> skip ;                         // Ignore Whitespace
