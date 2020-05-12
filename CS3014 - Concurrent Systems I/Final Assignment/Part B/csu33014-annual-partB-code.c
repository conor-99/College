//
// CSU33014 Summer 2020 Additional Assignment
// Part B of a two-part assignment
//
// Please write your solution in this file

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <omp.h>
#include <x86intrin.h>
#include "csu33014-annual-partB-person.h"

void find_reachable_recursive(struct person* current, int steps_remaining, bool* reachable) {

	// mark current root person as reachable
	reachable[person_get_index(current)] = true;

	// now deal with this person's acquaintances
	if ( steps_remaining > 0 ) {
		int num_known = person_get_num_known(current);
		for ( int i = 0; i < num_known; i++ ) {
			struct person * acquaintance = person_get_acquaintance(current, i);
			find_reachable_recursive(acquaintance, steps_remaining-1, reachable);
		}
	}

}

// computes the number of people within k degrees of the start person
int number_within_k_degrees(struct person* start, int total_people, int k) {

	bool* reachable;
	int count;

	// maintain a boolean flag for each person indicating if they are visited
	reachable = malloc(sizeof(bool)*total_people);
	for ( int i = 0; i < total_people; i++ ) {
		reachable[i] = false;
	}

	// now search for all people who are reachable with k steps
	find_reachable_recursive(start, k, reachable);

	// all visited people are marked reachable, so count them
	count = 0;
	for ( int i = 0; i < total_people; i++ ) {
		if ( reachable[i] == true ) {
			count++;
		}
	}

	return count;

}

/*
	=------------------------------------------=
	|  Less Redundant Number Within K Degrees  |
	=------------------------------------------=

	>-- Description --<

	The algorithm first creates an array of distances for each of
	the people in the graph and initialises each distance to -1.

	Starting at the initial person the algorithm recursively
	searches through each of their acquaintances using a depth-first
	search while keeping track of the distance from the starting
	person until the distance is equal to k.

	For each visited person the algorithm checks if they've already
	been visited and also if the stored distance is longer
	than the current distance. If the person has been visited and
	the distance is not shorter then return. Otherwise, store the
	current distance.

	Once the search has been completed the algorithm counts up the
	number of people with a distance not equal to -1 and returns the
	total count.

	>-- Complexity --<

	The original algorithm did not keep track of visited nodes and,
	as such, in the worst case, for every person, would visit every
	other person in the graph again. This resulted in a complexity
	of O(N^2), where N is the number of people in the graph.

	The modified algorithm usually only visits each person once.
	In certain cases, where there are shorter paths to reach people
	from the start node the algorithm will visit the same person
	multiple times - although these paths are relatively uncommon.
	The general complexity of the modified algorithm is O(N).

*/
void less_redundant_number_within_k_degrees_rec(struct person* node, int remaining, int* distances) {

	// get the current distance to this node from the root
	int dist = distances[person_get_index(node)];

	// if the node has been visited and our current path is longer then return
	if (dist != -1 && remaining < dist)
		return;

	// set the distance to this node to the current travelled distance
	distances[person_get_index(node)] = remaining;

	// if we can't travel any further then return
	if (!remaining)
		return;

	// repeat for all child nodes with a decreased remaining distance
	for (int i = 0; i < person_get_num_known(node); i++)
		less_redundant_number_within_k_degrees_rec(person_get_acquaintance(node, i), remaining - 1, distances);

}

int less_redundant_number_within_k_degrees(struct person* root, int max, int k) {

	int* distances;

	// mark all nodes as unvisited
	distances = malloc(sizeof(int) * max);
	for (int i = 0; i < max; i++)
		distances[i] = -1;

	// begin a recursive search at the root node
	less_redundant_number_within_k_degrees_rec(root, k, distances);

	// count all of the visited nodes
	int count = 0;
	for (int i = 0; i < max; i++)
		count += (distances[i] != -1) ? 1 : 0;
	
	return count;

}

/*
	=------------------------------------------=
	|   Parallelised Number Within K Degrees   |
	=------------------------------------------=

	>-- Description --<

	The first imlpenetation of parallelisation that was
	included in the algorithm was to add an OpenMP "parallel for"
	clause to both the instantiation of the 'distances' array at the
	beginning of the function and the counting up of the visited
	nodes at the end. An "atomic" clause was included in the latter
	part in order to ensure that the 'count' variable was only
	incremented the appropriate number of times.

	Additional parallelisation was added to the depth-first search
	aspect of the algorithm. Each recursive call to a node within
	two degrees of the root is parallelised using a "parellel for"
	clause with a conditional "if".

	Modifications to the 'distances' array are done inside of
	"critical" sections of code in order to multiple threads from
	modifying the same value.

	The rest of the algorithm is practically identical to the
	'less redundant' implementation previously described.

	>-- Complexity --<

	If there are P parallel processing cores and, assuming each core
	does the same amount of work, the complexity of the algorithm
	will be O(N/P). However, due to the parallelisation only being
	implemented for nodes within two degrees of the root node the
	complexity will only be O(N/P) if all of the nodes are within
	this region. To summarise, while the total number of operations
	is the same the increase in efficiency is due to the effect of
	running the search in multiple threads simulataneously.

*/

int parallel_max = -1;

void parallel_number_within_k_degrees_rec(struct person* node, int remaining, int* distances) {

	/*#pragma omp critical
	{
		if (omp_get_thread_num() != 0 || omp_get_num_threads() != 1)
			printf("cur=%d tot=%d\n", omp_get_thread_num(), omp_get_num_threads());
	}*/

	// get the current person's index
	int ix = person_get_index(node);

	// get the current distance to this node from the root
	int dist = distances[ix];

	// if the node has been visited and our current path is longer then return
	if (dist != -1 && remaining < dist)
		return;

	#pragma omp critical
	distances[ix] = remaining;

	// if we can't travel any further then return
	if (!remaining)
		return;

	// repeat for all child nodes with a decreased remaining distance
	#pragma omp parallel for if (remaining > parallel_max)
	for (int i = 0; i < person_get_num_known(node); i++) {
		#pragma omp task
		parallel_number_within_k_degrees_rec(person_get_acquaintance(node, i), remaining - 1, distances);
	}

}
int parallel_number_within_k_degrees(struct person* root, int max, int k) {

	parallel_max = k - 2;

	int* distances;
	int i;

	// mark all nodes as unvisited
	distances = malloc(sizeof(int) * max);
	#pragma omp parallel for
	for (i = 0; i < max; i++)
		distances[i] = -1;

	// begin a recursive search at the root node
	parallel_number_within_k_degrees_rec(root, k, distances);

	// count all of the visited nodes
	int count = 0;
	#pragma omp parallel for
	for (i = 0; i < max; i++) {
		if (distances[i] != -1) {
			#pragma omp atomic
			count++;
		}
	}
	
	return count;

}
