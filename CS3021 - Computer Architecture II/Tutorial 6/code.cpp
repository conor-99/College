#include <bits/stdc++.h>
using namespace std;

const int INPUT_SIZE = 32;
const int CACHE_SIZE = 128;
const int NONE = -1;

int cacheTime = 0; // for calculating LRU

class CacheObject {
public:

	int L, K, N;
	int setAddressLen;
	int hits, misses;

	vector< pair<int, int> > cache; // sets of size K with paired values <TAG, LAST_USED>

	CacheObject(int L, int K) {

		this->L = L;
		this->K = K;

		N = CACHE_SIZE / (L * K);
		
		setAddressLen = quickLog2(N);
		
		cache.resize(CACHE_SIZE);
		for (int i = 0; i < CACHE_SIZE; i++)
			cache[i] = make_pair(NONE, NONE);

		hits = 0;
		misses = 0;

	}

	void access(int address) {

		int offset = address & 0x000F;
		address >>= 4;
		int setNum = address & (N - 1);
		address >>= setAddressLen;
		int tag = address;
		
		int start = setNum * K;
		int end = start + K;
		
		int emptyIx = NONE;
		int minValIx = NONE, minVal = NONE;
		
		// LOOK FOR HIT
		for (int i = start; i < end; i++) {

			// HIT
			if ((cache[i].second != NONE) && (cache[i].first == tag)) {
				//printf("HIT  %d, %d\n", setNum, tag);
				cache[i].second = cacheTime;
				hits++;
				return;
			}

			// FIRST EMPTY SPACE
			if ((cache[i].second == NONE) && (emptyIx == NONE))
				emptyIx = i;
			
			// LEAST RECENTLY USED
			if ((minVal == NONE) || (cache[i].second <= minVal)) {
				minValIx = i;
				minVal = cache[i].second;
			}
			
		}

		//printf("MISS %d, %d\n", setNum, tag);
		
		// MISS
		int ixToSet = (emptyIx != NONE) ? emptyIx : minValIx;
		cache[ixToSet].first = tag;
		cache[ixToSet].second = cacheTime;

		misses++;

	}

	// count right shifts needed to set N to 0
	int quickLog2(int N) {
		int t = 0;
		while (N >>= 1) t++;
		return t;
	}

};

int main() {

	int addresses[INPUT_SIZE] = {
		0x0000, 0x0004, 0x000c, 0x2200, 0x00d0, 0x00e0, 0x1130, 0x0028,
		0x113c, 0x2204, 0x0010, 0x0020, 0x0004, 0x0040, 0x2208, 0x0008,
		0x00a0, 0x0004, 0x1104, 0x0028, 0x000c, 0x0084, 0x000c, 0x3390,
		0x00b0, 0x1100, 0x0028, 0x0064, 0x0070, 0x00d0, 0x0008, 0x3394
	};

	CacheObject cache1(16, 1);
	CacheObject cache2(16, 2);
	CacheObject cache3(16, 4);
	CacheObject cache4(16, 8);

	for (int i = 0; i < INPUT_SIZE; i++) {

		int address = addresses[i];

		cache1.access(address);
		cache2.access(address);
		cache3.access(address);
		cache4.access(address);

		cacheTime++;

	}

	printf("(i)   Cache(L=16, K=1) => hits = %d, misses = %d\n", cache1.hits, cache1.misses);
	printf("(ii)  Cache(L=16, K=2) => hits = %d, misses = %d\n", cache2.hits, cache2.misses);
	printf("(iii) Cache(L=16, K=4) => hits = %d, misses = %d\n", cache3.hits, cache3.misses);
	printf("(iv)  Cache(L=16, K=8) => hits = %d, misses = %d\n", cache4.hits, cache4.misses);

}
