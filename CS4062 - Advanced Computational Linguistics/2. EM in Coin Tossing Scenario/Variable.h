#include "SymTable.h"

#if !defined VARIABLE_H
#define VARIABLE_H

/*! \brief represents aspects of a variable 
 *
 * mainly a given variable has particular range of values that it can have
 * There is a symbol table included in the variable which maps the strings
 * that occur in files to represent these values to integers
 *
 * eg. a coin toss variable might map 'H' to 0, and 'T' to 1
 */
class Variable {
 public:
  Variable(void);
  void set_name(string);
  void set_range_size(int);
  string name;
  SymTable table; //!< symbol table mapping string values to integers 
  int range_size; //!< number of possible different value

 private:

};

#endif
