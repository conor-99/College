#include "CoinTrial.h"
#include "SymTable.h"
#include "Variable.h"
#include <iostream>
#include <string>

using namespace std;

extern Variable chce; 
extern Variable ht; 

CoinTrial::CoinTrial() {
  coin_choice = -1;
}

void CoinTrial::show() {

  cout << "CHOICE: " << chce.table.decode_to_symbol(coin_choice) << endl;
  cout << "TOSSES: ";
  cout << outcomes_string();

  cout << " ";

  for(int o=0; o < 2; o++) {
    cout  << ht.table.decode_to_symbol(o) <<  ":" << ht_cnts[o] << " ";
  }
  cout << endl;

}

string CoinTrial::outcomes_string() {
  string outcomes_s;
  for(unsigned int i=0; i < outcomes.size(); i++) {
    outcomes_s += ht.table.decode_to_symbol(outcomes[i]);
  }
  return outcomes_s;


}

void CoinTrial::set_ht_cnts() {
  // se the counts to zero
  for(int o = 0; o < 2 ; o++) {
    ht_cnts[o] = 0.0;
  }
  for(unsigned int i = 0; i < outcomes.size(); i++) {
    ht_cnts[outcomes[i]]++;
  }

}

