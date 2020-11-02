#include "prob_tables_coin.h"
#include <iostream>

using namespace std;

/*! \brief where z is code for a coin chice
  chce_probs[z] = P(chce=z) */
double chce_probs[2];

/*! \brief where y is code for a coin toss outcome
 * and z is code for a coin choice
 * ht_probs[z][y] = P(Toss=y| chce=z) */
double ht_probs[2][2];






