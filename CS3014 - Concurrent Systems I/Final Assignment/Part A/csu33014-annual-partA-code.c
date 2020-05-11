//
// CSU33014 Summer 2020 Additional Assignment
// Part A of a two-part assignment
//

// Please examine version each of the following routines with names
// starting partA. Where the routine can be vectorized, please
// complete the corresponding vectorized routine using SSE vector
// intrinsics. Where is cannot be vectorized...

// Note the restrict qualifier in C indicates that "only the pointer
// itself or a value directly derived from it (such as pointer + 1)
// will be used to access the object to which it points".


#include <immintrin.h>
#include <stdio.h>

#include "csu33014-annual-partA-code.h"

/****************  routine 0 *******************/

// Here is an example routine that should be vectorized
void partA_routine0(float * restrict a, float * restrict b, float * restrict c) {
	for (int i = 0; i < 1024; i++ ) {
		a[i] = b[i] * c[i];
	}
}

// here is a vectorized solution for the example above
void partA_vectorized0(float * restrict a, float * restrict b, float * restrict c) {

	__m128 a4, b4, c4;

	for (int i = 0; i < 1024; i = i+4 ) {
		b4 = _mm_loadu_ps(&b[i]);
		c4 = _mm_loadu_ps(&c[i]);
		a4 = _mm_mul_ps(b4, c4);
		_mm_storeu_ps(&a[i], a4);
	}

}

/***************** routine 1 *********************/

// in the following, size can have any positive value
float partA_routine1(float * restrict a, float * restrict b, int size) {

	float sum = 0.0;

	for ( int i = 0; i < size; i++ ) {
		sum = sum + a[i] * b[i];
	}

	return sum;

}

// insert vectorized code for routine1 here
float partA_vectorized1(float * restrict a, float * restrict b, int size) {

	__m128 s4 = _mm_set1_ps(0.f);
	__m128 a4, b4, m4;

	for (int i = 0; i < size; i += 4) {
		a4 = _mm_loadu_ps(&a[i]);
		b4 = _mm_loadu_ps(&b[i]);
		m4 = _mm_mul_ps(a4, b4);
		s4 = _mm_add_ps(m4, s4);
	}

	// add all values together
	s4 = _mm_hadd_ps(s4, s4);
	s4 = _mm_hadd_ps(s4, s4);

	return s4[0];

}

/******************* routine 2 ***********************/

// in the following, size can have any positive value
void partA_routine2(float * restrict a, float * restrict b, int size) {

	for ( int i = 0; i < size; i++ ) {
		a[i] = 1 - (1.0/(b[i]+1.0));
	}

}

// in the following, size can have any positive value
void partA_vectorized2(float * restrict a, float * restrict b, int size) {

	__m128 ones = _mm_set1_ps(1.f);
	__m128 a4, b4;

	int max = size - (size % 4);

	for (int i = 0; i < max; i += 4) {
		b4 = _mm_loadu_ps(&b[i]);
		a4 = _mm_add_ps(b4, ones);
		a4 = _mm_rcp_ps(a4);
		a4 = _mm_sub_ps(ones, a4);
		_mm_storeu_ps(&a[i], a4);
	}

	// calculate the remaining values normally
	for (int i = max; i < size; i++) {
		a[i] = 1.0 - (1.0 / (b[i] + 1.0));
	}

}

/******************** routine 3 ************************/

// in the following, size can have any positive value
void partA_routine3(float * restrict a, float * restrict b, int size) {

	for ( int i = 0; i < size; i++ ) {
		if ( a[i] < 0.0 ) {
			a[i] = b[i];
		}
	}

}

// in the following, size can have any positive value
void partA_vectorized3(float * restrict a, float * restrict b, int size) {

	__m128 zeros = _mm_setzero_ps();
	__m128 a4, b4, mask;
	
	int max = size - (size % 4);

	for (int i = 0; i < max; i += 4) {

		a4 = _mm_loadu_ps(&a[i]);
		b4 = _mm_loadu_ps(&b[i]);
		
		mask = _mm_cmplt_ps(a4, zeros);
		a4 = _mm_blendv_ps(a4, b4, mask);
		
		_mm_storeu_ps(&a[i], a4);

	}

	// calculate the remaining values normally
	for (int i = max; i < size; i++) {
		if (a[i] < 0.0) {
			a[i] = b[i];
		}
	}

}

/********************* routine 4 ***********************/

// hint: one way to vectorize the following code might use
// vector shuffle operations
void partA_routine4(float * restrict a, float * restrict b, float * restrict c) {

	for ( int i = 0; i < 2048; i = i+2  ) {
		a[i] = b[i]*c[i] - b[i+1]*c[i+1];
		a[i+1] = b[i]*c[i+1] + b[i+1]*c[i];
	}

}

void partA_vectorized4(float * restrict a, float * restrict b, float * restrict  c) {

	__m128 a4, b4, c4, bl, br, cl, cr, s, e, f, g;

	float signs[4] = {-1.0, 1.0, -1.0, 1.0};
	s = _mm_loadu_ps(&signs[0]);
	
	for (int i = 0; i < 2048; i += 4) {

		b4 = _mm_loadu_ps(&b[i]);
		c4 = _mm_loadu_ps(&c[i]);

		bl = _mm_shuffle_ps(b4, b4, _MM_SHUFFLE(2, 2, 0, 0));
		br = _mm_shuffle_ps(b4, b4, _MM_SHUFFLE(3, 3, 1, 1));
		cl = _mm_shuffle_ps(c4, c4, _MM_SHUFFLE(3, 2, 1, 0));
		cr = _mm_shuffle_ps(c4, c4, _MM_SHUFFLE(2, 3, 0, 1));

		e = _mm_mul_ps(bl, cl);
		f = _mm_mul_ps(br, cr);
		g = _mm_mul_ps(s, f);
		a4 = _mm_add_ps(e, g);

		_mm_storeu_ps(&a[i], a4);

	}

}

/********************* routine 5 ***********************/

// in the following, size can have any positive value
void partA_routine5(unsigned char * restrict a, unsigned char * restrict b, int size) {

	for ( int i = 0; i < size; i++ ) {
		a[i] = b[i];
	}

}

void partA_vectorized5(unsigned char * restrict a, unsigned char * restrict b, int size) {

	__m128i b4;

	int max = size - (size % 4);

	for (int i = 0; i < max; i += 4) {
		b4 = _mm_loadu_si128((__m128i*) &b[i]);
		_mm_storeu_si128((__m128i*) &a[i], b4);
	}

	// calculate the remaining values normally
	for (int i = max; i < size; i++) {
		a[i] = b[i];
	}

}

/********************* routine 6 ***********************/

void partA_routine6(float * restrict a, float * restrict b, float * restrict c) {

	a[0] = 0.0;

	for ( int i = 1; i < 1023; i++ ) {
		float sum = 0.0;
		for ( int j = 0; j < 3; j++ ) {
			sum = sum +  b[i+j-1] * c[j];
		}
		a[i] = sum;
	}

	a[1023] = 0.0;

}

void partA_vectorized6(float * restrict a, float * restrict b, float * restrict c) {
	
	c[3] = 0.f;
	__m128 c4 = _mm_loadu_ps(&c[0]);
	__m128 b4;

	a[0] = 0.0;

	for (int i = 1; i < 1023; i++) {

		b4 = _mm_loadu_ps(&b[i - 1]);
		b4 = _mm_mul_ps(b4, c4);
		b4 = _mm_hadd_ps(b4, b4);
		b4 = _mm_hadd_ps(b4, b4);
		a[i] = b4[0];

	}

	a[1023] = 0.0;

}
