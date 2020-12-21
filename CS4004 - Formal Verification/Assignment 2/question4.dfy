predicate isMax(s: array<int>, lo:int)
    reads s
{
    (0 <= lo < s.Length) && (forall i :: (0 <= i < s.Length) ==> s[i] <= s[lo])
}

method findMax(s: array<int>) returns (lo:int, hi:int)
    requires s.Length >= 0
    ensures true
{
    lo := 0;
    hi := s.Length - 1;
    while lo < hi
        invariant lo >= 0 && hi < s.Length
        decreases hi - lo
    {
        if (s[lo] <= s[hi]) {
            lo := lo + 1;
        } else {
            hi := hi - 1;
        }
    }
}

predicate isPal(s: array<int>)
    reads s
{
    forall i :: (0 <= i < s.Length) ==> s[i] <= s[s.Length - i - 1]
}

method checkPalindrome(s: array<int>) returns (res:int)
    requires s.Length >= 0
    ensures true
{
    res := 1;
    var i := 0;
    var j := s.Length - 1;
    while (i < j) && (res == 1)
        invariant i >= 0 && j < s.Length
        decreases j - i
    {
        if (s[i] != s[j]) {
            res := 0;
        } else { }
        i := i + 1;
        j := j - 1;
    }
}
