from scheme_types import Pair

class SchemeOperations:
    @staticmethod
    def _integer_division(args):
        if len(args) < 2:
            raise Exception("Division requires at least two arguments")
        if args[1] == 0:
            raise Exception("Division by zero")
        result = args[0]
        for divisor in args[1:]:
            if divisor == 0:
                raise Exception("Division by zero")
            dividend = result
            negative = (dividend < 0) != (divisor < 0)
            dividend, divisor = abs(dividend), abs(divisor)
            result = -(dividend // divisor) if negative else dividend // divisor
        return result

    @staticmethod
    def _car(lst):
        if not isinstance(lst, Pair):
            raise Exception("car: expected list, got something else")
        return lst.car

    @staticmethod
    def _cdr(lst):
        if not isinstance(lst, Pair):
            raise Exception("cdr: expected list, got something else")
        return lst.cdr

    @staticmethod
    def _make_list(elements):
        if not elements:
            return None
        return Pair(elements[0], SchemeOperations._make_list(elements[1:]))

    @staticmethod
    def _display(value):
        if isinstance(value, bool):
            print('#t' if value else '#f', end='')
        elif isinstance(value, str):
            print(value, end='')
        elif isinstance(value, Pair):
            print(str(value), end='')
        else:
            print(str(value), end='')
        return None

    @staticmethod
    def _newline():
        print()
        return None

    @staticmethod
    def _read():
        try:
            user_input = input()
            try:
                return int(user_input)
            except ValueError:
                if user_input.startswith('"') and user_input.endswith('"'):
                    return user_input[1:-1]
                return user_input
        except EOFError:
            raise Exception("Error reading input")
