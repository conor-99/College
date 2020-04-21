//
// CSU33014 Summer 2020 Additional Assignment
// Part A of a two-part assignment
//
// For instructions see csu33014-annual-partA-code.c
//
// PLEASE DO NOT CHANGE ANY CODE IN THIS FILE

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include "csu33014-annual-partA-code.h"

/* test code for the routines to be vectorized */

// seed the pseudo-random number generator using the system clock
void initialize_random() {
  struct timeval seedtime;
  int seed;
  
  /* use the microsecond part of the current time as a pseudorandom seed */
  gettimeofday(&seedtime, NULL);
  seed = seedtime.tv_usec;
  fprintf(stderr, "seed %d\n", seed);
  srandom(seed);
}

// generate a random integer, which may or may not be signed
int get_random(int range, int is_signed) {
  int num = random();
  int sign = random();

  num = num % range;
  // if signed, then 50% should be negative
  if ( is_signed && (sign % 2 == 1) ) {
    num = -num;
  }
  return num;
}

// create a new array of float with random values
float * new_random_float_array(int size, int is_signed) {
  int range = 1024;
  float * out = malloc(sizeof(float) * size);

  for ( int i = 0; i < size; i++ ) {
    out[i] = get_random(range, is_signed);
  }
  return out;
}

// create a new array of characters with random values
unsigned char * new_random_char_array(int size) {
  int range = 256;
  int is_signed = 0;
  unsigned char * out = malloc(sizeof(float) * size);

  for ( int i = 0; i < size; i++ ) {
    out[i] = get_random(range, is_signed);
  }
  return out;
}

// compute square of distance between two arrays
double diff_square(float * a, float * b, int size) {
  double sum = 0.0;
  for ( int i = 0; i < size; i++ ) {
    double diff = a[i] - b[i];
    //fprintf(stderr, "a[%d]: %f, b[%d]: %f\n", i, a[i], i, b[i]);
    sum = sum + diff * diff;
  }
  return sum;
}

// generate four arrays to use in testing
void gen_test_arrays(float ** out_correct, float ** out_vectorized,
		     float ** b, float **c, int size) {
  *out_correct = malloc(sizeof(float) * size);
  *out_vectorized = malloc(sizeof(float) * size);
  *b = new_random_float_array(size, 1);
  *c = new_random_float_array(size, 1);
}

void free_arrays(float * x, float *y, float *z, float * w) {
  free(x);
  free(y);
  free(z);
  free(w);
}

// simple test of routine 0
void test_routine0() {
  int size = 1024;
  float * out_correct, * out_vectorized, *b, *c;
  double diff;

  gen_test_arrays(&out_correct, &out_vectorized, &b, &c, size);

  partA_routine0(out_correct, b, c);
  partA_vectorized0(out_vectorized, b, c);

  diff = diff_square(out_correct, out_vectorized, size);

  free_arrays(out_correct, out_vectorized, b, c);
  
  printf("routine0 diff: %lf\n", diff);
}

// simple test of routine 1
void test_routine1() {
  int size = get_random(2048, 0) + 10; // get a random size > 10
  float * a = new_random_float_array(size, 1);
  float * b = new_random_float_array(size, 1);
  float out_correct, out_vectorized;
  double diff;

  out_vectorized = partA_vectorized1(a, b, size);
  out_correct = partA_routine1(a, b, size);
  //fprintf(stderr, "%f %f\n", out_correct, out_vectorized);
  
  free(a);
  free(b);
  
  diff = out_correct - out_vectorized;

  fprintf(stderr, "routine1 diff: %lf\n", diff);
}

// simple test of routine 2
void test_routine2() {
  int size = get_random(2048, 0) + 10; // get a random size >= 10
  float * out_correct = malloc(sizeof(float)*size);
  float * out_vectorized = malloc(sizeof(float)*size);
  float * b = new_random_float_array(size, 0);
  double diff;

  partA_routine2(out_correct, b, size);
  partA_vectorized2(out_vectorized, b, size);

  diff = diff_square(out_correct, out_vectorized, size);

  free(out_correct);
  free(out_vectorized);
  free(b);
 
  fprintf(stderr, "routine2 diff: %lf\n", diff);
}


// create a copy of an existing array
float * clone_float_array(float * src, int size) {
  float * dest = malloc(sizeof(float)*size);
  for ( int i = 0; i < size; i++ ) {
    dest[i] = src[i];
  }
  return dest;
}

// simple test of routine 3
void test_routine3() {
  int size = get_random(2048, 0) + 10; // get a random size > 10
  float * out_correct = new_random_float_array(size, 1);
  float * out_vectorized = clone_float_array(out_correct, size);
  float * b = new_random_float_array(size, 1);
  double diff;

  // fprintf(stderr, "out_correct %p, out_vectorized %p, b %p, size %d\n", out_correct, out_vectorized, b, size);

  partA_routine3(out_correct, b, size);
  partA_vectorized3(out_vectorized, b, size);

  diff = diff_square(out_correct, out_vectorized, size);

  free(out_correct);
  free(out_vectorized);
  free(b);
  
  fprintf(stderr, "routine3 diff: %lf\n", diff);
}

// simple test of routine 4
void test_routine4() {
  int size = 2048;
  float * out_correct, * out_vectorized, *b, *c;
  double diff;
  
  gen_test_arrays(&out_correct, &out_vectorized, &b, &c, size);

  partA_routine4(out_correct, b, c);
  partA_vectorized4(out_vectorized, b, c);
  
  diff = diff_square(out_correct, out_vectorized, size);
  
  free_arrays(out_correct, out_vectorized, b, c);
  
  fprintf(stderr, "routine4 diff: %lf\n", diff);
}


// simple test of routine 5
void test_routine5() {
  int size = get_random(2048, 0) + 10; // get a random size > 10
  unsigned char * out_correct = malloc(sizeof(unsigned char)*size);
  unsigned char * out_vectorized = malloc(sizeof(unsigned char)*size);
  unsigned char * b = new_random_char_array(size);
  int sum_diff;

  partA_routine5(out_correct, b, size);
  partA_vectorized5(out_vectorized, b, size);

  sum_diff = 0;
  for ( int i = 0; i < size; i++ ) {
    int diff = out_correct[i] - out_vectorized[i];
    sum_diff = sum_diff + (diff * diff);
  }

  free(out_correct);
  free(out_vectorized);
  free(b);
  
  fprintf(stderr, "routine5 diff: %d\n", sum_diff);
}

void test_routine6() {
  int size = 1024;
  float * out_correct, * out_vectorized, *b, *c;
  double diff;

  gen_test_arrays(&out_correct, &out_vectorized, &b, &c, size);

  partA_routine6(out_correct, b, c);
  partA_vectorized6(out_vectorized, b, c);

  diff = diff_square(out_correct, out_vectorized, size);

  free_arrays(out_correct, out_vectorized, b, c);
  
  fprintf(stderr, "routine6 diff: %lf\n", diff);
}

// simple main function containing code to test each
// 
int main() {
  initialize_random();
  test_routine0();
  test_routine1();
  test_routine2();
  test_routine3();
  test_routine4();
  test_routine5();
  test_routine6(); 
  
  return 0;
}
