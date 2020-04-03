from math import sqrt
from random import choices, uniform
import matplotlib.pyplot as plt

def parse_timings():
	return tuple(zip(*[list(map(int, line.strip().split())) \
		for line in open("dataset_timings.txt").readlines()]))

def parse_probabilities():
	return tuple(map(float, open("dataset_probabilities.txt")\
		.readline().split()))

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

	cheb_lo, cheb_hi = mu - (sigma / sqrt(0.05 * N)), \
	mu + (sigma / sqrt(0.05 * N))
	clt_lo, clt_hi = mu - (2 * (sigma / sqrt(N))), \
	mu + (2 * (sigma / sqrt(N)))

	print("95%% CI - Chebyshev: %.4f <= X <= %.4f" % \
		(cheb_lo, cheb_hi))
	print("95%% CI - CLT: %.4f <= X <= %.4f" % \
		(clt_lo, clt_hi))

def conf_intervals_bootstrap(timings):
	
	N = len(timings)
	S = 1000
	
	# sample 20% of dataset (with replacement) 1000 times
	means = []
	for i in range(S):
		sample = choices(timings, k=int(0.2 * N))
		means.append(prob(sample))

	mu = sum(means) / len(means)
	sigma = sqrt(mu - (mu ** 2))
	
	cheb_lo, cheb_hi = mu - (sigma / sqrt(0.05 * N)), \
	mu + (sigma / sqrt(0.05 * N))
	clt_lo, clt_hi = mu - (2 * (sigma / sqrt(N))), \
	mu + (2 * (sigma / sqrt(N)))

	print("95%% CI - BS Chebyshev: %.4f <= X <= %.4f" % \
		(cheb_lo, cheb_hi))
	print("95%% CI - BS CLT: %.4f <= X <= %.4f" % \
		(clt_lo, clt_hi))

def prob_z(all_timings, probs):
	return sum(prob(all_timings[i]) * probs[i] \
		for i in range(len(all_timings)))

def sim_z(all_timings, prob_request):

	prob_timing = list(map(prob, all_timings))

	S = 100000
	count = 0
	for _ in range(S):

		# what user did the request come from?
		user_prob = uniform(0, 1)
		user_i = -1
		prob_sum = 0
		for i in range(len(prob_request)):
			prob_sum += prob_request[i]
			if user_prob <= prob_sum:
				user_i = i
				break

		# did the request take longer than 10ms?
		req_prob = uniform(0, 1)
		if req_prob <= prob_timing[user_i]:
			count += 1

	return count / S

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
print(prob_z(all_timings, probs))

# Q5
print(sim_z(all_timings, probs))
