sum(N) --> [N].
sum(N) --> {mkList(N, L)}, {member(X, L)}, {Y is N - X}, {Y > 0}, [X], sum(Y).

mkList(1, [1]).
mkList(X, [X|T]) :- X > 1, Y is X - 1, mkList(Y, T).
