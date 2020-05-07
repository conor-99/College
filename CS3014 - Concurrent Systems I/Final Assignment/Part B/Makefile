all: csu33014-annual-partB-code.c  csu33014-annual-partB-main.c  csu33014-annual-partB-person.c csu33014-annual-partB-code.h  csu33014-annual-partB-person.h
	gcc -O2 -o graph csu33014-annual-partB-code.c  csu33014-annual-partB-main.c  csu33014-annual-partB-person.c

debug: csu33014-annual-partB-code.c  csu33014-annual-partB-main.c  csu33014-annual-partB-person.c csu33014-annual-partB-code.h  csu33014-annual-partB-person.h
	gcc -g -o graph csu33014-annual-partB-code.c  csu33014-annual-partB-main.c  csu33014-annual-partB-person.c

sanitize: csu33014-annual-partB-code.c  csu33014-annual-partB-main.c  csu33014-annual-partB-person.c csu33014-annual-partB-code.h  csu33014-annual-partB-person.h
	gcc -g  -fsanitize=address-o graph csu33014-annual-partB-code.c  csu33014-annual-partB-main.c  csu33014-annual-partB-person.c

test: all
	./graph
