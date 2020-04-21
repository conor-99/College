//
// CSU33014 Summer 2020 Additional Assignment
// Part B of a two-part assignment
//
// Header file with declarations of functions that we want to test

#ifndef CSU33014_ANNUAL_PARTB_CODE_H
#define CSU33014_ANNUAL_PARTB_CODE_H

// computes the number of people within k degrees of the start person
int number_within_k_degrees(struct person * start, int total_people, int k);

// computes the number of people within k degrees of the start person;
// less repeated computation than the simple original version
int less_redundant_number_within_k_degrees(struct person * start,
					   int total_people, int k);

// computes the number of people within k degrees of the start person;
// parallel version of the code
int parallel_number_within_k_degrees(struct person * start,
				     int total_people, int k);

#endif
