from enum import Enum


class Corner(Enum):
	Exercise = 0
	Relax = 1


class State(Enum):
	Fit = 0
	Unfit = 1
	Dead = 2


# combined probability and reward matrices
# - indexed by corner, starting state and finishing state
M = {
	Corner.Exercise: {
		State.Fit: {
			State.Fit: ((0.9 * 0.99), 8),
			State.Unfit: ((0.9 * 0.01), 8),
			State.Dead: (0.1, 0)
		},
		State.Unfit: {
			State.Fit: ((0.9 * 0.2), 0),
			State.Unfit: ((0.9 * 0.8), 0),
			State.Dead: (0.1, 0)
		},
		State.Dead: {
			State.Fit: (0.0, 0),
			State.Unfit: (0.0, 0),
			State.Dead: (1.0, 0)
		}
	},
	Corner.Relax: {
		State.Fit: {
			State.Fit: ((0.99 * 0.7), 10),
			State.Unfit: ((0.99 * 0.3), 10),
			State.Dead: (0.01, 0)
		},
		State.Unfit: {
			State.Fit: ((0.99 * 0.0), 5),
			State.Unfit: ((0.99 * 1.0), 5),
			State.Dead: (0.01, 0)
		},
		State.Dead: {
			State.Fit: (0.0, 0),
			State.Unfit: (0.0, 0),
			State.Dead: (1.0, 0)
		}
	}
}
S = [State.Fit, State.Unfit, State.Dead]
G = 0.0


# return the probability of transitioning from s -> t in corner a
def p(s, a, t):
	return M[a][s][t][0]

# return the reward for transitioning from s -> t in corner a
def r(s, a, t):
	return M[a][s][t][1]


# memoized implementation of Vn 
_V = {}
def V(n, s):
	k = (n, s)
	if k not in _V:
		_V[k] = max(q(n, s, Corner.Exercise), q(n, s, Corner.Relax))
	return _V[k]


# memoized implementation of qn
_q = {}
def q(n, s, a):
	k = (n, s, a)
	if k not in _q:
		if n == 0:
			_q[k] = sum(p(s, a, t) * r(s, a, t) for t in S)
		else:
			_q[k] = q(0, s, a) + (G * sum(p(s, a, t) * V(n - 1, t) for t in S))
	return _q[k]


# print out values of qn for each corner for all values <= n
def show(n, s, g):
	global G, _q, _V
	G, _q, _V = g, {}, {}
	for m in range(n + 1):
		print(f"n={m} exer:{q(m, s, Corner.Exercise)} relax:{q(m, s, Corner.Relax)}")
	return q(n, s, Corner.Exercise), q(n, s, Corner.Relax)


# examples
show(10, State.Fit, 0.5)
show(8, State.Unfit, 0.8)
show(10, State.Dead, 0.99)
