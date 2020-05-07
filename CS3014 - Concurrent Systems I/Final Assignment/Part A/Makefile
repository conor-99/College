all: csu33014-annual-partA-code.c csu33014-annual-partA-code.h csu33014-annual-partA-main.c
	gcc -msse4 -O2 -o vec csu33014-annual-partA-code.c csu33014-annual-partA-main.c

debug: csu33014-annual-partA-code.c csu33014-annual-partA-code.h csu33014-annual-partA-main.c
	gcc -msse4 -g -o vec csu33014-annual-partA-code.c csu33014-annual-partA-main.c

test: all
	./vec
