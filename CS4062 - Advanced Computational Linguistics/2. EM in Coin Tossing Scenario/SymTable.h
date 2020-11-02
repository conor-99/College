#include <vector>
#include <map>
#include <string>
//#include <stdlib.h>

using namespace std;

#if !defined SYMTABLE_H
#define SYMTABLE_H
/*! \brief class for a symbol table mapping the strings which are the values of variables 
 * to integers representing those strings */
class SymTable {
 public:
  SymTable(void);

  int symbol_total; //!< the total number of symbols in the table
  int get_code(string cat);
  int check_code(string cat);

  string decode_to_symbol(int code); 
  map<string,int> the_symbols;

 private:
  map<int,string> sym_decoder;

};

#endif
