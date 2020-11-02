CPPFLAGS = -g

SymTable.o: SymTable.cpp SymTable.h
	g++ $(CPPFLAGS) -c SymTable.cpp

Variable.o: Variable.cpp Variable.h SymTable.h
	g++ $(CPPFLAGS) -c Variable.cpp

CoinTrial.o: CoinTrial.cpp CoinTrial.h SymTable.h
	g++ $(CPPFLAGS) -c CoinTrial.cpp

prob_tables_coin.o: prob_tables_coin.cpp prob_tables_coin.h CoinTrial.h SymTable.h Variable.h
	g++ $(CPPFLAGS) -c prob_tables_coin.cpp

make_gamma: make_gamma.cpp prob_tables_coin.o SymTable.o CoinTrial.o Variable.o
	g++ $(CPPFLAGS) make_gamma.cpp prob_tables_coin.o SymTable.o CoinTrial.o Variable.o -o make_gamma

clean:
	rm make_gamma prob_tables_coin.o SymTable.o CoinTrial.o Variable.o
