//
// CSU33014 Summer 2020 Additional Assignment
// Part A of a two-part assignment
//
// For instructions see csu33014-annual-partA-code.c

#ifndef csu330140_annual_partA_code_H
#define csu330140_annual_partA_code_H

void partA_routine0(float * restrict a, float * restrict b,
		    float * restrict c);
void partA_vectorized0(float * restrict a, float * restrict b,
		       float * restrict c);
float partA_routine1(float * restrict a, float * restrict b,
		     int size);
float partA_vectorized1(float * restrict a, float * restrict b,
			int size);
void partA_routine2(float * restrict a, float * restrict b, int size);
void partA_vectorized2(float * restrict a, float * restrict b, int size);
void partA_routine3(float * restrict a, float * restrict b, int size);
void partA_vectorized3(float * restrict a, float * restrict b, int size);
void partA_routine4(float * restrict a, float * restrict b,
		    float * restrict c);
void partA_vectorized4(float * restrict a, float * restrict b,
		       float * restrict  c);
void partA_routine5(unsigned char * restrict a,
		    unsigned char * restrict b, int size);
void partA_vectorized5(unsigned char * restrict a,
		       unsigned char * restrict b, int size);
void partA_routine6(float * restrict a, float * restrict b,
		    float * restrict c);
void partA_vectorized6(float * restrict a, float * restrict b,
		       float * restrict c);

#endif
