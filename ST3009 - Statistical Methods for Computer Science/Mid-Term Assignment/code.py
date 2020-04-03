from math import sqrt
from random import choices
import matplotlib.pyplot as plt


def parse_timings():
	return tuple(zip(*[list(map(int, line.strip().split())) for line in open("dataset_timings.txt").readlines()]))


def parse_probabilities():
	return tuple(map(float, open("dataset_probabilities.txt").readline().split()))


def pmf_hist(timings):
	plt.hist(timings, 50, density=True)
	plt.show()


def prob(timings):

	rv = lambda x: 1 if x > 10 else 0
	count = sum(rv(timing) for timing in timings)

	return count / len(timings)


def conf_intervals(timings):

	N = len(timings)
	mu = prob(timings)
	sigma = sqrt(mu - (mu ** 2))

	cheb_lo, cheb_hi = mu - (sigma / sqrt(0.05 * N)), mu + (sigma / sqrt(0.05 * N))
	clt_lo, clt_hi = mu - (2 * (sigma / sqrt(N))), mu + (2 * (sigma / sqrt(N)))

	print("95%% CI - Chebyshev: %.4f <= X <= %.4f" % (cheb_lo, cheb_hi))
	print("95%% CI - CLT: %.4f <= X <= %.4f" % (clt_lo, clt_hi))


def conf_intervals_bootstrap(timings):
	
	N = len(timings)
	
	# sample 20% of dataset (with replacement) 1000 times
	means = []
	for i in range(1000):
		sample = choices(timings, k=int(0.2 * N))
		means.append(prob(sample))

	mu = sum(means) / len(means)
	sigma = sqrt(mu - (mu ** 2))
	
	cheb_lo, cheb_hi = mu - (sigma / sqrt(0.05 * N)), mu + (sigma / sqrt(0.05 * N))
	clt_lo, clt_hi = mu - (2 * (sigma / sqrt(N))), mu + (2 * (sigma / sqrt(N)))

	print("95%% CI - BS Chebyshev: %.4f <= X <= %.4f" % (cheb_lo, cheb_hi))
	print("95%% CI - BS CLT: %.4f <= X <= %.4f" % (clt_lo, clt_hi))


# Data
all_timings = parse_timings()
probs = parse_probabilities()

# Q1(a)
pmf_hist(all_timings[0])

# Q1(b)
print(prob(all_timings[0]))

# Q1(c)
conf_intervals(all_timings[0])
conf_intervals_bootstrap(all_timings[0])

# Q2
for timings in all_timings[1:]:
	print(prob(timings))

# Q3
# to-do