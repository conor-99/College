/* Time taken: 3 hours total */

predicate isPrefixPred(pre:string, str:string)
{
	(|pre| <= |str|) && 
	pre == str[..|pre|]
}

predicate isNotPrefixPred(pre:string, str:string)
{
	(|pre| > |str|) || 
	pre != str[..|pre|]
}

lemma PrefixNegationLemma(pre:string, str:string)
	ensures  isPrefixPred(pre,str) <==> !isNotPrefixPred(pre,str)
	ensures !isPrefixPred(pre,str) <==>  isNotPrefixPred(pre,str)
{}

method isPrefix(pre:string, str:string) returns (res:bool)
	ensures !res <==> isNotPrefixPred(pre,str)
	ensures  res <==> isPrefixPred(pre,str)
{
	if |pre| > |str| { return false; }
	else { return pre == str[..|pre|]; }
}

predicate isSubstringPred(sub:string, str:string)
{
	(exists i :: 0 <= i <= |str| &&  isPrefixPred(sub,str[i..]))
}

predicate isNotSubstringPred(sub:string, str:string)
{
	(forall i :: 0 <= i <= |str| ==> isNotPrefixPred(sub,str[i..]))
}

lemma SubstringNegationLemma(sub:string, str:string)
	ensures  isSubstringPred(sub,str) <==> !isNotSubstringPred(sub,str)
	ensures !isSubstringPred(sub,str) <==>  isNotSubstringPred(sub,str)
{}

method isSubstring(sub:string, str:string) returns (res:bool)
	ensures res <==> isSubstringPred(sub,str)
	//ensures !res <==> isNotSubstringPred(sub,str) // This postcondition follows from the above lemma.
{
	if (|str| < |sub|) { return false; }
	var i:int := 0;
	while i <= |str|
		invariant 0 <= i <= |str| + 1
		// no prefix seen so far
		invariant forall j :: 0 <= j < i ==> isNotPrefixPred(sub,str[j..])
		decreases |str| - i
	{
		var isPre:bool := isPrefix(sub,str[i..]);
		if isPre { return true; }
		i := i + 1;
	}
	return false;
}

predicate haveCommonKSubstringPred(k:nat, str1:string, str2:string)
{
	exists i1, j1 :: 0 <= i1 <= |str1|- k && j1 == i1 + k && isSubstringPred(str1[i1..j1],str2)
}

predicate haveNotCommonKSubstringPred(k:nat, str1:string, str2:string)
{
	forall i1, j1 :: 0 <= i1 <= |str1|- k && j1 == i1 + k ==>  isNotSubstringPred(str1[i1..j1],str2)
}

lemma commonKSubstringLemma(k:nat, str1:string, str2:string)
	ensures  haveCommonKSubstringPred(k,str1,str2) <==> !haveNotCommonKSubstringPred(k,str1,str2)
	ensures !haveCommonKSubstringPred(k,str1,str2) <==>  haveNotCommonKSubstringPred(k,str1,str2)
{}

method haveCommonKSubstring(k:nat, str1:string, str2:string) returns (found:bool)
	ensures found <==> haveCommonKSubstringPred(k,str1,str2)
	//ensures !found <==> haveNotCommonKSubstringPred(k,str1,str2) // This postcondition follows from the above lemma.
{
	if |str1| < k || |str2| < k { return false; }
	if k == 0 {
		assert isPrefixPred(str1[0..0],str2[0..]);
		return true;
	}
	var i:int := 0;
	while i <= |str1| - k
		invariant 0 <= i <= |str1| - k + 1
		// no substring seen so far
		invariant forall j1, j2 :: 0 <= j1 < i && j2 == j1 + k ==> isNotSubstringPred(str1[j1..j2],str2)
		decreases |str1| - k - i
	{
		var isSub:bool := isSubstring(str1[i..(i+k)],str2);
		if isSub { return true; }
		i := i + 1;
	}
	return false;
}

method maxCommonSubstringLength(str1: string, str2: string) returns (len:nat)
	requires (|str1| <= |str2|)
	// changed this from '!haveCommon...' to 'haveNotCommon...'  to make it consistent with previous methods
	ensures forall k :: len < k <= |str1| ==> haveNotCommonKSubstringPred(k,str1,str2)
	ensures haveCommonKSubstringPred(len,str1,str2)
{
	var i:int := |str1|;
	while 0 < i
		invariant 0 <= i <= |str1|
		// no common K-sub seen so far
		invariant forall j :: i < j <= |str1| ==> haveNotCommonKSubstringPred(j,str1,str2)
		decreases i
	{
		var hasSub:bool := haveCommonKSubstring(i,str1,str2);
		if hasSub { return i; }
		i := i - 1;
	}
	assert isPrefixPred(str1[0..0],str2[0..]);
	return i;
}
