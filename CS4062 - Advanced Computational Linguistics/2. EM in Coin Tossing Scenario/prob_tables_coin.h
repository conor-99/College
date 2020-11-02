using namespace std;

// where z is code for a coin chice
// chce_probs[z] = P(chce=z)
extern double chce_probs[2];

// where y is code for a coin toss outcome
// and z is code for a coin choice
// ht_probs[z][y] = P(Toss=y| chce=z)
extern double ht_probs[2][2];

