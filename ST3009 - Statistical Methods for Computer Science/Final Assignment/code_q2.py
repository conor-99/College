from math import sqrt
from random import choices, uniform
import matplotlib.pyplot as plt

def parse_marks():
	return tuple(zip(*[list(map(int, line.strip().split())) \
		for line in open("dataset_timings.txt").readlines()]))

def pmf_hist(timings):
	plt.hist(timings, 50, density=True)
	plt.show()

# Data
marks = parse_marks()

# Question 2 (a)
pmf_hist(marks[0])
