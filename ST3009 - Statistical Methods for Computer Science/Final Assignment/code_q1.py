import matplotlib.pyplot as plt
import numpy as np
from math import sqrt
from random import choice, sample
from scipy.special import comb


# Questions 1 (c) and 1 (d)
def plot_prob(n, p):	
	plt.plot(n, p, 'r')
	plt.xlabel(r'$n$')
	plt.ylabel('Probability')
	plt.title(r'Probability of failing having studied $n$ topics')
	plt.xticks(np.arange(0, 11, 1))
	plt.yticks(np.arange(0, 1.1, 0.1))
	plt.show()


n = np.linspace(0, 10, 11)

# Question 1 (c)
p1 = (comb(10 - n, 3) + (comb(10 - n, 2) * n)) / 120
plot_prob(n, p1)

# Question 1 (d)
p2 = (comb(10 - n, 4) + (comb(10 - n, 3) * n)) / 210
plot_prob(n, p2)


# Question 1 (e)
def sim_e(n):
	topics = list(range(10))
	studied = set(sample(topics, n))
	exam = set(sample(topics, 3))
	return 1 if len(exam & studied) >= 2 else 0


# Question 1 (f)
def sim_f(n, N):
	mean = sum(sim_e(n) for _ in range(N)) / N
	var = mean * (1 - mean)
	ci = (mean - 2 * sqrt(var / N), mean + 2 * sqrt(var / N))
	return mean, var, ci


print(sim_f(7, 1000))
print(sim_f(7, 10000))


# Question 1 (g)
def sim_g(n, N, sims):
	lo, hi = sim_f(n, N)[2]
	means = [sim_f(n, N)[0] for _ in range(sims)]
	count = sum(map(lambda mean: mean >= lo and mean <= hi, means))
	return count / sims


print(sim_g(7, 1000, 500))
print(sim_g(7, 10000, 500))


# Question 1 (h)
def sim_h(n, N, change):
	passes = 0
	for _ in range(N):
		# assume topics 0, 1, 2 were on previous exam
		if change < 0:
			studied = set(list(range(10))[-n:])
			biased = list(range(3, 10))
		else:
			studied = set(range(n))
			biased = list(range(3))
		topics = list(range(10))
		for topic in biased:
			topics.extend([topic] * abs(change))
		exam = set([])
		while len(exam) != 3:
			exam.add(choice(topics))
		passes += 1 if len(exam & studied) >= 2 else 0
	return passes / N


for change in range(-5, 6):
	print(change, sim_h(5, 10000, change))
