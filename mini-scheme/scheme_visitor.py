from antlr4 import *
from schemeParser import schemeParser
from schemeVisitor import schemeVisitor
from scheme_types import Symbol, Function, Pair
from scheme_operations import SchemeOperations

class MySchemeVisitor(schemeVisitor):
    def __init__(self):
        super().__init__()
        self.scopes = [{}]        
        self.functions = {}       
        
        # Basic operations supported by the interpreter
        self.operations = {
            '+': lambda args: sum(args),
            '-': lambda args: args[0] - sum(args[1:]) if len(args) > 1 else -args[0],
            '*': lambda args: args[0] if len(args) == 1 else args[0] * self.operations['*'](args[1:]),
            '/': lambda args: SchemeOperations._integer_division(args),
            
            '=': lambda args: args[0] == args[1],
            '>': lambda args: args[0] > args[1],
            '<': lambda args: args[0] < args[1],
            '>=': lambda args: args[0] >= args[1],
            '<=': lambda args: args[0] <= args[1],
            '<>': lambda args: args[0] != args[1],
            
            'and': lambda args: all(args),
            'or': lambda args: any(args),
            'not': lambda args: not args[0],
            
            'car': lambda args: SchemeOperations._car(args[0]),
            'cdr': lambda args: SchemeOperations._cdr(args[0]),
            'cons': lambda args: Pair(args[0], args[1]),
            'null?': lambda args: args[0] is None,
            
            'procedure?': lambda args: isinstance(args[0], Function),
            
            'display': lambda args: SchemeOperations._display(args[0]),
            'newline': lambda args: SchemeOperations._newline()
        }

    def _display_value(self, value):
        if isinstance(value, Symbol):
            try:
                return str(self.get_variable(value.name))
            except:
                return value.name
        elif isinstance(value, Pair):
            return str(self._display_pair(value))
        else:
            return str(value)

    def _display_pair(self, pair):
        if isinstance(pair.cdr, Pair) or pair.cdr is None:
            elements = []
            current = pair
            while isinstance(current, Pair):
                elements.append(self._display_value(current.car))
                current = current.cdr
            if current is not None:
                elements.append('.')
                elements.append(self._display_value(current))
            return '(' + ' '.join(elements) + ')'
        else:
            return f'({self._display_value(pair.car)} . {self._display_value(pair.cdr)})'

    def push_scope(self, variables):
        self.scopes.append(variables)

    def pop_scope(self):
        if len(self.scopes) > 1:
            return self.scopes.pop()
        return {}

    def get_variable(self, name):
        for scope in reversed(self.scopes):
            if name in scope:
                return scope[name]
        raise Exception(f"Undefined variable: {name}")

    def capture_current_scope(self):
        captured = {}
        for scope in reversed(self.scopes):
            captured.update(scope)
        return captured

    def merge_scopes(self, closure, local_scope):
        if closure:
            merged = closure.copy()
            merged.update(local_scope)
            return merged
        return local_scope

    def _make_list(self, elements):
        if not elements:
            return None
        return Pair(elements[0], self._make_list(elements[1:]))

    def visitRoot(self, ctx):
        self.visit(ctx.defines())
        result = self.visit(ctx.main())
        return result

    def visitDefines(self, ctx):
        for define in ctx.define():
            self.visit(define)
        return None

    def visitMain(self, ctx):
        result = None
        for expr in ctx.expression():
            if isinstance(expr, schemeParser.OperationContext):
                result = self.visitOperation(expr)
            else:
                result = self.visit(expr)
        return result

    def visitOperation(self, ctx):
        operator = self.visit(ctx.operator())
        args = [self.visit(expr) for expr in ctx.expression()]
        
        if isinstance(operator, str):
            return self._handle_builtin_operation(operator, args)
        if isinstance(operator, Function):
            return self._handle_user_function(operator, args)
        
        raise Exception(f"Invalid operation: {operator}")
    
    def _handle_builtin_operation(self, operator, args):
        if operator not in self.operations:
            raise Exception(f"Unknown operation: {operator}")
        return self.operations[operator](args)
    
    def _handle_user_function(self, function, args):
        self._validate_function_args(function, args)
        return self._execute_function(function, args)
    
    def _validate_function_args(self, function, args):
        if len(args) != len(function.params):
            raise Exception(
                f"Function {function.name} expects {len(function.params)} arguments, "
                f"got {len(args)}"
            )
    
    def _execute_function(self, function, args):
        param_bindings = dict(zip(function.params, args))
        new_scope = self.merge_scopes(function.closure, param_bindings)
        
        self.push_scope(new_scope)
        try:
            result = None
            for expr in function.body:
                result = self.visit(expr)
            return result
        finally:
            self.pop_scope()

    def visitOperator(self, ctx):
        op_text = ctx.getText()
        
        if op_text in self.operations:
            return op_text
        
        try:
            if ctx.VAR():
                return self.get_variable(op_text)
        except Exception as e:
            raise Exception(f"Undefined function: {op_text}")
        
        raise Exception(f"Invalid operator: {op_text}")

    def visitDefineFunction(self, ctx):
        func_name = ctx.VAR(0).getText()
        params = [param.getText() for param in ctx.VAR()[1:]]
        
        function = Function(
            name=func_name,
            params=params,
            body=ctx.expression(),
            closure=self.capture_current_scope()
        )
        
        self.scopes[0][func_name] = function
        return None
    
    def visitDefineConstant(self, ctx):
        const_name = ctx.VAR().getText()
        value = self.visit(ctx.expression())
        self.scopes[0][const_name] = value
        return None

    def visitIfExpr(self, ctx):
        condition = self.visit(ctx.expression(0))
        return self.visit(ctx.expression(1)) if condition != False else self.visit(ctx.expression(2))

    def visitCondExpr(self, ctx):
        clauses = ctx.condClause()
    
        def is_else_clause(expr):
            return (isinstance(expr, schemeParser.VariableContext) and 
                    expr.VAR().getText() == 'else')
        
        def is_true_clause(expr):
            return (isinstance(expr, schemeParser.BooleanContext) and 
                    expr.BOOL().getText() == '#t')
        
        def handle_special_clause(clause, index, keyword):
            if index < len(clauses) - 1:
                raise Exception(f"{keyword} clause must be last in cond expression")
            return self.visit(clause.expression(1))
        
        for i, clause in enumerate(clauses):
            condition_expr = clause.expression(0)
            
            if is_else_clause(condition_expr):
                return handle_special_clause(clause, i, 'else')
                
            if is_true_clause(condition_expr):
                return handle_special_clause(clause, i, '#t')
            
            condition_result = self.visit(condition_expr)
            if condition_result is not False:
                return self.visit(clause.expression(1))
    
        return None

    def visitLetExpr(self, ctx):
        new_scope = {}
        
        for binding in ctx.binding():
            var_name = binding.VAR().getText()
            if var_name in self.scopes[0]:
                raise Exception(f"Error: Cannot redefine global variable '{var_name}'")
        
        for binding in ctx.binding():
            var_name, var_value = self.visit(binding)
            new_scope[var_name] = var_value
        
        self.push_scope(new_scope)
        try:
            result = None
            for expr in ctx.expression():
                result = self.visit(expr)
            return result
        finally:
            self.pop_scope()

    def visitNormalBinding(self, ctx):
        var_name = ctx.VAR().getText()
        var_value = self.visit(ctx.expression())
        return (var_name, var_value)

    def visitReadBinding(self, ctx):
        var_name = ctx.VAR().getText()
        var_value = SchemeOperations._read()
        return (var_name, var_value)

    def visitDisplayExpr(self, ctx):
        value = self.visit(ctx.expression())
        return SchemeOperations._display(value)

    def visitNewlineExpr(self, ctx):
        return SchemeOperations._newline()

    def visitNumber(self, ctx):
        return int(ctx.NUM().getText())

    def visitBoolean(self, ctx):
        return ctx.BOOL().getText() == '#t'
    
    def visitString(self, ctx):
        return ctx.STRING().getText()[1:-1]

    def visitVariable(self, ctx):
        var_name = ctx.VAR().getText()
        value = self.get_variable(var_name)
        if isinstance(value, Function) and isinstance(ctx.parentCtx, schemeParser.OperationContext):
            return value
        elif isinstance(value, Function) and len(value.params) == 0:
            self.push_scope(value.closure or {})
            try:
                result = None
                for expr in value.body:
                    result = self.visit(expr)
                return result
            finally:
                self.pop_scope()
        return value

    def visitQuotedExpr(self, ctx):
        result = self._quote(ctx.expression())
        return result

    def _quote(self, expr):
        if isinstance(expr, schemeParser.NumberContext):
            value = self.visitNumber(expr)
            return value
            
        elif isinstance(expr, schemeParser.BooleanContext):
            value = self.visitBoolean(expr)
            return value
            
        elif isinstance(expr, schemeParser.StringContext):
            value = self.visitString(expr)
            return value
            
        elif isinstance(expr, schemeParser.ListContext):
            elements = []
            for e in expr.expression():
                if isinstance(e, schemeParser.VariableContext):
                    var_name = e.VAR().getText()
                    try:
                        value = self.get_variable(var_name)
                        elements.append(value)
                    except:
                        elements.append(var_name)
                else:
                    value = self._quote(e)
                    elements.append(value)
            result = self._make_list(elements)
            return result
            
        elif isinstance(expr, schemeParser.OperationContext):
            elements = []
            
            operator = expr.operator()
            if isinstance(operator, schemeParser.OperatorContext):
                if operator.VAR():
                    var_name = operator.VAR().getText()
                    try:
                        value = self.get_variable(var_name)
                        elements.append(value)
                    except:
                        elements.append(var_name)
            
            for e in expr.expression():
                if isinstance(e, schemeParser.VariableContext):
                    var_name = e.VAR().getText()
                    try:
                        value = self.get_variable(var_name)
                        elements.append(value)
                    except:
                        elements.append(var_name)
                else:
                    value = self._quote(e)
                    elements.append(value)
            return self._make_list(elements)
            
        elif isinstance(expr, schemeParser.EmptyListContext):
            return None
            
        elif isinstance(expr, schemeParser.VariableContext):
            var_name = expr.VAR().getText()
            try:
                value = self.get_variable(var_name)
                return value
            except:
                return var_name
        
        else:
            value = expr.getText()
            return value

    def visitEmptyList(self, ctx):
        return None

    def visitList(self, ctx):
        elements = [self.visit(expr) for expr in ctx.expression()]
        return self._make_list(elements)
