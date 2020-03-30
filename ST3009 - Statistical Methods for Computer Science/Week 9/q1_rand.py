from random import uniform
import matplotlib.pyplot as plt


def random_point(f, max_step, start_x, iterations, max_tries):
	results = [None] * iterations
	results[0] = start_x
	min_x = start_x
	for i in range(1, iterations):
		min_x = results[i - 1]
		x = min_x
		tries = 0
		while f(x) >= f(min_x) and tries < max_tries:
			x = min_x + uniform(-max_step, max_step)
			tries += 1
		# if we didn't run out of tries
		if f(x) < f(min_x):
			min_x = x
		results[i] = min_x
	return results


f = lambda x: (x * x) - 1
max_step = 0.1  # max absolute change in x after each iteration
start_x = uniform(-1, 1)  # start at a random point
iterations = 100  # number of iterations to run
max_tries = 50  # max number of tries to descend each iteration

results = random_point(f, max_step, start_x, iterations, max_tries)
plt.plot(list(map(f, results)))
plt.show()
