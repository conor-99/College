def parse_timings():
	return tuple(zip(*[list(map(int, line.strip().split())) for line in open("dataset_timings.txt").readlines()]))

def parse_probabilities():
	return tuple(map(float, open("dataset_probabilities.txt").readline().split()))

def pmf_hist(timings):
	return

def prob(timings, value):
	return

def conf_intervals(timings, value):
	return
