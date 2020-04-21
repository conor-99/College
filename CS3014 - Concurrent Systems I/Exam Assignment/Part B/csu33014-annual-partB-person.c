//
// CSU33014 Summer 2020 Additional Assignment
// Part B of a two-part assignment
//
// C code file for the person abstract datatype
//
// Please do not change anything in this file

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include "csu33014-annual-partB-person.h"

// return the person's unique index between zero and #people-1
int person_get_index(struct person * p) {
  return p->person_index;
}

// return the number of people known by a person
int person_get_num_known(struct person * p) {
  return p->number_of_known_people;
}

// get the index'th person known by p
struct person * person_get_acquaintance(struct person * p, int index) {
  //fprintf(stderr, "index %d, num_known %d\n", index, p->number_of_known_people);
  assert( (index >= 0) && (index < p->number_of_known_people) );
  return p->known_people[index];
}

// create a new person with index and no connections
struct person * person_new(int index) {
  struct person * result;
  result = malloc(sizeof(struct person));
  result->person_index = index;
  result->known_people = NULL;
  result->number_of_known_people = 0;
  return result;
}

// return whether there is a connection from person a to person b
bool person_is_connected(struct person * a, struct person * b) {
  for (int i = 0; i < a->number_of_known_people; i++ ) {
    if ( a->known_people[i] == b ) {
      return true;
    }
  }
  return false;
}

// add a connection from person a to person b
void person_add_connection(struct person * a, struct person * b) {
  if ( a->number_of_known_people == 0 ) {
    // allocate space for one known person
    a->known_people = malloc(sizeof(struct person*));
  }
  else {
    // increase the space in the array of known people with realloc
    a->known_people = realloc(a->known_people, sizeof(struct person *)
			      *(a->number_of_known_people+1));
  }
  assert( a->known_people != NULL );
  a->known_people[a->number_of_known_people] = b;
  a->number_of_known_people++;
}
