from sicp import *  # NOQA


def ex_2_41(n, s):
    def sequence(n, parent):
        """ make sequence """
        if n == 0 or length(parent) > 2:
            return (parent,)

        else:
            return flatmap(
                lambda i: sequence(i - 1, append(parent, (i,))),
                enumerate_inerval(1, n)
            )

    return filter(
        lambda t: sum(t) == s,  # filter by sum of a triple
        filter(
            lambda l: length(l) == 3,  # filetr triples
            sequence(n, ())
        )
    )


assert ex_2_41(5, 11) == ((5, 4, 2),)
assert ex_2_41(6, 11) == ((5, 4, 2), (6, 3, 2), (6, 4, 1))
