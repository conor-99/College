% Read in knowledge base
:- dynamic(kb/1).
makeKB(File) :- open(File, read, Str), readK(Str, K), reformat(K, KB), asserta(kb(KB)), close(Str).
readK(Stream, []) :- at_end_of_stream(Stream), !.
readK(Stream, [X|L]) :- read(Stream, X), readK(Stream, L).
reformat([],[]).
reformat([end_of_file],[]) :- !.
reformat([:-(H, B)|L], [[H|BL]|R]) :- !, mkList(B, BL), reformat(L, R).
reformat([A|L], [[A]|R]) :- reformat(L, R).
mkList((X, T), [X|R]) :- !, mkList(T, R).
mkList(X, [X]).
initKB(File) :- retractall(kb(_)), makeKB(File).

% A* search steps
%  (1) Get children of node and calculate cost
%  (2) Add children to frontier
%  (3) Sort frontier nodes ascending
%  (4) Repeat A* on frontier

astar(Node, Path, Cost) :-
	kb(KB),
	astar([[Node, [], 0]], Path, Cost, KB).

% reached goal
astar([[Node, Path, Cost]|_], [Node, Path], Cost, _) :- goal(Node).
% otherwise
astar([[Node, CurPath, CurCost]|Tail], TotalPath, TotalCost, KB) :-	
	findall([Child, [Node|CurPath], NewCost], (arc(Node, Child, ChildCost, KB), NewCost is CurCost + ChildCost), Children),
	append(Children, Tail, Frontier),
	sortfrontier(Frontier, Sorted),
	astar(Sorted, TotalPath, TotalCost, KB).

% given in assignment
goal([]).
heuristic(Node, H) :- length(Node, H).
arc([H|T], Node, Cost, KB) :-
	member([H|B], KB),
	append(B, T, Node),
	length(B, L),
	Cost is L + 1.

% sort the frontier nodes by costs
sortfrontier([Head|Tail], Result) :- sortfrontier2(Head, [], Tail, Result).
sortfrontier2(Head, Start, [], [Head|Start]).
sortfrontier2(Head1, Start, [Head2|Tail], Result) :-
	less(Head1, Head2), !,
	sortfrontier2(Head1, [Head2|Start], Tail, Result); sortfrontier2(Head2, [Head1|Start], Tail, Result).

% check if the first cost is less than the second
less([Node1, _, Cost1|_], [Node2, _, Cost2|_]) :-
	heuristic(Node1, Heur1),
	heuristic(Node2, Heur2),
	Total1 is Cost1 + Heur1,
	Total2 is Cost2 + Heur2,
	Total1 =< Total2.
