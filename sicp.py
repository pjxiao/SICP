from operator import add, or_, and_, not_


__all__ = [
    'map', 'filter', 'accumulate', 'flatmap', 'enumerate_inerval',
    'append', 'length',
    'or_', 'and_', 'not_',
]


def compose(*fs):
    """ compose functions """
    return _reduce(lambda f, g: lambda *a, **k: f(g(*a, **k)), fs)


# escape builtin functions
_map = map
_reduce = reduce
_filter = filter


map = compose(tuple, _map,)
filter = compose(tuple, _filter)
length = len
append = add


def accumulate(op, initial, sequence):
    if len(sequence) == 0:
        return initial

    return tuple(_reduce(op, sequence, initial))


def enumerate_inerval(low, high):
    return tuple(range(low, high + 1))


def flatmap(proc, seq):
    return accumulate(add, (), map(proc, seq))
