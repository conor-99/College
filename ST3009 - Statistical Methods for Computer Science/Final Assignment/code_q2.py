import matplotlib.pyplot as plt
import numpy as np
from math import sqrt
from statistics import mean, variance


# Dataset
def parse_marks():
	return tuple(zip(*[list(map(int, line.strip().split())) \
		for line in open("dataset.txt").readlines()[1:]]))


marks = parse_marks()


# Question 2 (a)
def pmf_hist(marks, question):
	plt.hist(marks[question], 21, density=True, edgecolor='black')
	plt.xlabel('marks')
	plt.ylabel('frequency')
	plt.title(f'PMF of marks for question {question + 1}')
	plt.xticks(np.arange(0, 110, 10))
	plt.yticks(np.arange(0, 0.09, 0.01))
	plt.show()


for question in range(3):
	pmf_hist(marks, question)


# Question 2 (b)
def mark_cond(marks):
	q1_marks = {}
	for i in range(1000):
		q1, q2, q3 = marks[0][i], marks[1][i], marks[2][i]
		if q1 not in q1_marks:
			q1_marks[q1] = [[], []]
		q1_marks[q1][0].append(q2)
		q1_marks[q1][1].append(q3)
	data = {}
	for mark in q1_marks:
		mean_q2, mean_q3 = int(round(mean(q1_marks[mark][0]))), int(round(mean(q1_marks[mark][1])))
		var_q2, var_q3 = variance(q1_marks[mark][0]), variance(q1_marks[mark][1])
		data[mark] = (mean_q2, var_q2, mean_q3, var_q3, len(q1_marks[mark][0]), len(q1_marks[mark][1]))
	return data


cond_data = mark_cond(marks)
for mark in cond_data:
	cond_datum = cond_data[mark]
	print(
		'q1_mark=%d, mean_q2=%d, var_q2=%.2f, mean_q3=%d, var_q3=%.2f' %
		(mark, cond_datum[0], cond_datum[1], cond_datum[2], cond_datum[3])
	)


# Question 2 (c)
def mark_cond_conf(marks):
	cond_data = mark_cond(marks)
	labels = list(map(str, range(0, 105, 5)))
	q2_marks = [cond_data[mark][0] for mark in sorted(cond_data)]
	q3_marks = [cond_data[mark][2] for mark in sorted(cond_data)]
	q2_clts = [2 * sqrt(cond_data[mark][1]) / sqrt(cond_data[mark][4]) for mark in sorted(cond_data)]
	q3_clts = [2 * sqrt(cond_data[mark][3]) / sqrt(cond_data[mark][5]) for mark in sorted(cond_data)]
	x, w = np.arange(len(labels)), 0.35
	fig, ax = plt.subplots()
	ax.bar(x - w / 2, q2_marks, w, label='Q2 mark', color='sandybrown', yerr=q2_clts, ecolor='maroon', capsize=2)
	ax.bar(x + w / 2, q3_marks, w, label='Q3 mark', color='steelblue', yerr=q3_clts, ecolor='maroon', capsize=2)
	ax.set_xlabel('Mark on Q1')
	ax.set_ylabel('Marks on Q2 and Q3')
	ax.set_title('Marks on Q2 and Q3 conditioned on Q1 with 95% CIs')
	ax.set_xticks(x)
	ax.set_xticklabels(labels)
	ax.set_yticks(np.arange(0, 110, 10))
	ax.legend()
	fig.tight_layout()
	plt.show()


mark_cond_conf(marks)
