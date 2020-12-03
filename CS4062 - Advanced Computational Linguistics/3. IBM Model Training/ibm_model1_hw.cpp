#include<vector>
#include<string>
#include<iostream>
#include<iomanip>
#include<cmath>

using namespace std;

// want to represents vocab items by integers because then various tables 
// need by the IBM model and EM training can just be represented as 2-dim 
// tables indexed by integers

// the following #defines, defs of VS, VO, S, O, and create_vocab_and_data()
// are set up to deal with the specific case of the two pair corpus
// (la maison/the house)
// (la fleur/the flower)

// S VOCAB
#define LA 0
#define MAISON 1
#define FLEUR 2
// O VOCAB
#define THE 0
#define HOUSE 1
#define FLOWER 2

#define VS_SIZE 3
#define VO_SIZE 3
#define D_SIZE 2

vector<string> VS(VS_SIZE); // S vocab: VS[x] gives Src word coded by x 
vector<string> VO(VO_SIZE); // O vocab: VO[x] gives Obs word coded by x

vector<vector<int>> S(D_SIZE); // all S sequences; in this case 2
vector<vector<int>> O(D_SIZE); // all O sequences; in this case 2

// sets S[0] and S[1] to be the int vecs representing the S sequences
// sets O[0] and O[1] to be the int vecs representing the O sequences
void create_vocab_and_data(); 

// functions which use VS and VO to 'decode' the int vecs representing the 
// Src and Obs sequences
void show_pair(int d);
void show_O(int d); 
void show_S(int d);

// display results of each iteration
void display_iteration_results(int iter);
// pad string to output easier to read
string pad(string str);

// initialise vectors for counts and transition probabilities
vector<vector<double>> counts(VO_SIZE, vector<double>(VS_SIZE));
vector<vector<double>> probs(VO_SIZE, vector<double>(VS_SIZE));

int main() {
    create_vocab_and_data();
    
    // calculate initial probabilities
    for (int i = 0; i < VO_SIZE; i++)
        for (int j = 0; j < VS_SIZE; j++)
            probs[i][j] = 1 / (double) VS_SIZE;
    
    display_iteration_results(-1);
    
    for (int iter = 0; iter < 50; iter++) {
        // reset counts to zero
        for (int i = 0; i < VO_SIZE; i++)
            for (int j = 0; j < VS_SIZE; j++)
                counts[i][j] = 0;
        
        // calculate counts
        for (int d = 0; d < D_SIZE; d++) {
            for (int j = 0; j < O[d].size(); j++) {        
                // only calculate denominator in p(...) once
                int o = O[d][j];
                double denom = 0;
                for (int i = 0; i < S[d].size(); i++) {
                    int s = S[d][i];
                    denom += probs[o][s];
                }

                for (int i = 0; i < S[d].size(); i++) {
                    int s = S[d][i];
                    counts[o][s] += probs[o][s] / denom;
                }
            }
        }

        // calculate probabilities
        for (int i = 0; i < VS_SIZE; i++) {
            // only calculate denominator in tr(...) once
            double denom = 0;
            for (int j = 0; j < VO_SIZE; j++) {
                denom += counts[j][i];
            }

            for (int j = 0; j < VO_SIZE; j++) {
                probs[j][i] = counts[j][i] / denom;
            }
        }

        display_iteration_results(iter);
    }
}

void display_iteration_results(int iter) {
    if (iter == -1) {
        printf("initial trans probs are\n");
        for (int i = 0; i < VS_SIZE; i++)
            for (int j = 0; j < VO_SIZE; j++)
                cout << VO[j] << pad(VO[j]) << VS[i] << pad(VS[i]) << probs[j][i] << endl;
    } else {
        printf("unnormalised counts in iteration %d are\n", iter);
        for (int i = 0; i < VS_SIZE; i++)
            for (int j = 0; j < VO_SIZE; j++)
                cout << VO[j] << pad(VO[j]) << VS[i] << pad(VS[i]) << counts[j][i] << endl;

        printf("after iteration %d trans probs are\n", iter);
        for (int i = 0; i < VS_SIZE; i++)
            for (int j = 0; j < VO_SIZE; j++)
                cout << VO[j] << pad(VO[j]) << VS[i] << pad(VS[i]) << probs[j][i] << endl;
    }
}

string pad(string str) {
    return string(8 - str.length(), ' ');
}

void create_vocab_and_data() {
    VS[LA] = "la";
    VS[MAISON] = "maison";
    VS[FLEUR] = "fleur";

    VO[THE] = "the";
    VO[HOUSE] = "house";
    VO[FLOWER] = "flower";

    cout << "source vocab\n";
    for (int vi = 0; vi < VS.size(); vi++) {
        cout << VS[vi] << " ";
    }
    cout << endl;
    cout << "observed vocab\n";
    for (int vj = 0; vj < VO.size(); vj++) {
        cout << VO[vj] << " ";
    }
    cout << endl;

    // make S[0] be {LA, MAISON}
    //      O[0] be {THE, HOUSE}
    S[0] = {LA, MAISON};
    O[0] = {THE, HOUSE};

    // make S[1] be {LA, FLEUR}
    //      O[1] be {THE, FLOWER}
    S[1] = {LA, FLEUR};
    O[1] = {THE, FLOWER};

    for (int d = 0; d < S.size(); d++) {
        show_pair(d);
    }
}

void show_O(int d) {
    for (int i = 0; i < O[d].size(); i++) {
        cout << VO[O[d][i]] << " ";
    }
}

void show_S(int d) {
    for (int i = 0; i < S[d].size(); i++) {
        cout << VS[S[d][i]] << " ";
    }
}

void show_pair(int d) {
    cout << "S" << d << ": ";
    show_S(d);
    cout << endl;
    cout << "O" << d << ": ";
    show_O(d);
    cout << endl;
}
