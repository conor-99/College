/* Time taken: 1.5 hours total */

predicate isPrefixPred(pre:string, str:string) {
    (|pre| <= |str|) && (pre == str[..|pre|])
}

predicate isNotPrefixPred(pre:string, str:string) {
    (|pre| > |str|) || (pre != str[..|pre|])
}

lemma PrefixNegationLemma(pre:string, str:string)
    ensures  isPrefixPred(pre, str) <==> !isNotPrefixPred(pre, str)
    ensures !isPrefixPred(pre, str) <==>  isNotPrefixPred(pre, str)
{}

predicate isSubstringPred(sub:string, str:string) {
    exists i :: 0 <= i <= (|str| - |sub|) && isPrefixPred(sub, str[i..])
}

predicate isNotSubstringPred(sub:string, str:string) {
    forall i :: i < 0 || i > (|str| - |sub|) || isNotPrefixPred(sub, str[i..])
}

lemma SubstringNegationLemma(sub:string, str:string)
    ensures  isSubstringPred(sub, str) <==> !isNotSubstringPred(sub, str)
    ensures !isSubstringPred(sub, str) <==>  isNotSubstringPred(sub, str)
{}

predicate haveCommonKSubstringPred(k:nat, str1:string, str2:string) {
    // need to include j as str[i..(i+k)] doesn't work
    (k == 0)
    || (exists i, j :: 0 <= i < j <= (|str1| - k) && j == i + k && isSubstringPred(str1[i..j], str2))
    || (exists i, j :: 0 <= i < j <= (|str2| - k) && j == i + k && isSubstringPred(str2[i..j], str1))
}

predicate haveNotCommonKSubstringPred(k:nat, str1:string, str2:string) {
    // need to include j as str[i..(i+k)] doesn't work
    (k != 0)
    && (forall i, j :: i < 0 || j < 0 || i > (|str1| - k) || j > (|str1| - k) || j != i + k || isNotSubstringPred(str1[i..j], str2))
    && (forall i, j :: i < 0 || j < 0 || i > (|str2| - k) || j > (|str2| - k) || j != i + k || isNotSubstringPred(str2[i..j], str1))
}

lemma commonKSubstringLemma(k:nat, str1:string, str2:string)
    ensures  haveCommonKSubstringPred(k, str1, str2) <==> !haveNotCommonKSubstringPred(k, str1, str2)
    ensures !haveCommonKSubstringPred(k, str1, str2) <==> haveNotCommonKSubstringPred(k, str1, str2)
{}
