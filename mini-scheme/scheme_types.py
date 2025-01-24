class Symbol:
    """
    Representation of a symbol in Scheme.
    """
    def __init__(self, name):
        self.name = name
    
    def __str__(self):
        return self.name

class Function:
    """
    Representation of a user-defined function in Scheme
    Saves the name, parameters, body and closure.
    """
    def __init__(self, name, params, body, closure=None):
        self.name = name
        self.params = params
        self.body = body
        self.closure = closure
    
    def __str__(self):
        return f"#<function:{self.name}>"

class Pair:
    """
    Implements the basic list structure in Scheme.
    Contains a first element (car) and the rest of the list (cdr).
    """
    def __init__(self, car, cdr):
        self.car = car
        self.cdr = cdr
    
    def __str__(self):
        if isinstance(self.cdr, Pair) or self.cdr is None:
            elements = []
            current = self
            while isinstance(current, Pair):
                if isinstance(current.car, bool):
                    elements.append('#t' if current.car else '#f')
                else:
                    elements.append(str(current.car))
                current = current.cdr
            if current is not None:
                elements.append('.')
                if isinstance(current, bool):
                    elements.append('#t' if current else '#f')
                else:
                    elements.append(str(current))
            return '(' + ' '.join(elements) + ')'
        else:
            car_str = '#t' if isinstance(self.car, bool) and self.car else '#f' if isinstance(self.car, bool) else str(self.car)    
            cdr_str = '#t' if isinstance(self.cdr, bool) and self.cdr else '#f' if isinstance(self.cdr, bool) else str(self.cdr)
            return f'({car_str} . {cdr_str})'
