#include "SymTable.h"
#include <fstream>
#include <iostream>

//#include <algorithm>

using namespace std;


SymTable::SymTable() {
  int symbol_total = 0;

  the_symbols.clear(); 
  sym_decoder.clear();
}

/*! \brief this adds word to the sym table if it is not there */
int SymTable::get_code(string word) {
  map<string,int>::const_iterator symbol_table_itr;
  symbol_table_itr = the_symbols.find(word);
  int code;
  if(symbol_table_itr != the_symbols.end()) {
    code = symbol_table_itr->second;
  }
  else {
   code = symbol_total;
   the_symbols[word] = code; 
   sym_decoder[code] = word;
   symbol_total++;
  }
    
  return code;

}

/*! \brief this looks word up and returns -1 if it is not in the table */
int SymTable::check_code(string word) {
  map<string,int>::const_iterator symbol_table_itr;
  symbol_table_itr = the_symbols.find(word);
  if(symbol_table_itr != the_symbols.end()) {
    return symbol_table_itr->second;
  }
  else { 
    return -1;
  }
}

/*! \brief goes back from a code to the original string symbol */
string SymTable::decode_to_symbol(int code) {
  if(code >= 0 && code < symbol_total) {
    return sym_decoder[code];
  }
  else { 
    return "none";
  }
}

