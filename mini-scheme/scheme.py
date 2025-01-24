import sys
from antlr4 import *
from schemeLexer import schemeLexer
from schemeParser import schemeParser
from scheme_visitor import MySchemeVisitor
from antlr4.error.ErrorListener import ErrorListener

class SyntaxErrorListener(ErrorListener):
    def syntaxError(self, recognizer, offendingSymbol, line, column, msg, e):
        print(f"Error in line {line}, column {column}: {msg}", 
              file=sys.stderr)
        sys.exit(1)

def main():
    if len(sys.argv) != 2:
        print("Usage: python3 scheme.py file.scm", file=sys.stderr)
        sys.exit(1)
    
    filename = sys.argv[1]
    if not filename.endswith('.scm'):
        print(f"Error: File must have the extension .scm", file=sys.stderr)
        sys.exit(1)
    
    try:
        input_stream = FileStream(sys.argv[1], encoding='utf-8')
        lexer = schemeLexer(input_stream)
        stream = CommonTokenStream(lexer)
        parser = schemeParser(stream)
        
        parser.removeErrorListeners()
        parser.addErrorListener(SyntaxErrorListener())
        
        tree = parser.root()
        visitor = MySchemeVisitor()
        
        try:
            visitor.visit(tree)
        except Exception as e:
            print(str(e), file=sys.stderr)
            sys.exit(1)
                
    except Exception as e:
        print(str(e), file=sys.stderr)
        sys.exit(1)

if __name__ == '__main__':
    main()
