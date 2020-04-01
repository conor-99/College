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
	count = sum(1 if rv(timing) == 1 else 0 for timing in timings)
	return count / len(timings)

def conf_intervals(timings):
	return


# Data
all_timings = parse_timings()
probs = parse_probabilities()

# Q1(a)
pmf_hist(all_timings[0])

# Q1(b)
print(prob(all_timings[0]))

# Q1(c)
conf_intervals(all_timings[0])

# Q2
for timings in all_timings[1:]:
	print(prob(timings))
