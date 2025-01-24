all: scheme.py
	antlr4 -Dlanguage=Python3 -no-listener -visitor scheme.g4

clean:
	rm -f *.interp *.tokens *Parser.py *Lexer.py *Visitor.py
	rm -rf __pycache__

.PHONY: all clean
