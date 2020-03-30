from random import uniform
import matplotlib.pyplot as plt


def gradient_descent(df, alpha, start_x, iterations):
	theta = [None] * iterations
	theta[0] = start_x
	for i in range(1, iterations):
		theta[i] = theta[i - 1] - (alpha * df(theta[i - 1]))
	return theta


f = lambda x: (x * x) - 1
df = lambda x: 2 * x
start_x = uniform(-1, 1)  # start at a random point
iterations = 100  # number of iterations to run

for alpha in [1.0, 0.1, 0.01]:
	results = gradient_descent(df, alpha, start_x, iterations)
	plt.plot(list(map(f, results)))
	plt.show()
