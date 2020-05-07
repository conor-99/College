//
// CSU33014 Summer 2020 Additional Assignment
// Part B of a two-part assignment
//
// Header file for the person abstract datatype
//
// Please do not change anything in this file

#ifndef CSU33014_ANNUAL_PARTB_PERSON_H
#define CSU33014_ANNUAL_PARTB_PERSON_H

struct person {
  int person_index; // each person has an index 0..(#people-1)
  struct person ** known_people;
  int number_of_known_people;
};

// create a new person with index and no connections
struct person * person_new(int index);

// return the person's unique index between zero and #people-1
int person_get_index(struct person * p);

// return the number of people known by a person
int person_get_num_known(struct person * p);

// get the index'th person known by p
struct person * person_get_acquaintance(struct person * p, int index);

// add a connection from person a to person b
void person_add_connection(struct person * a, struct person * b);

// return whether there is a connection from person a to person b
bool person_is_connected(struct person * a, struct person * b);

#endif
