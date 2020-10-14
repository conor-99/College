method isPrefix(pre: string, str: string) returns (res: bool) {
    if |str| < |pre| { return false; }
    else { return forall i :: 0 <= i < |pre| ==> pre[i] == str[i]; }
}

method isSubstring(sub: string, str: string) returns (res: bool) {
    if |str| < |sub| { return false; }
    var i: int := 0;
    while i <= |str| - |sub| {
        var hasPref: bool := isPrefix(sub, str[i..]);
        if hasPref { return true; }
        i := i + 1;
    }
    return false;
}

method haveCommonKSubstring(k: nat, str1: string, str2: string) returns (found: bool) {
    if k == 0 { return true; }
    var i: int := 0;
    while i <= |str1| - k {
        var isSub: bool := isSubstring(str1[i..(i + k)], str2);
        if isSub { return true; }
        i := i + 1;
    }
    i := 0;
    while i <= |str2| - k {
        var isSub: bool := isSubstring(str2[i..(i + k)], str1);
        if isSub { return true; }
        i := i + 1;
    }
    return false;
}

method maxCommonSubstringLength(str1: string, str2: string) returns (len: nat) {
    var i: int := if |str1| <= |str2| then |str1| else |str2|;
    while 0 <= i {
        var hasSub: bool := haveCommonKSubstring(i, str1, str2);
        if hasSub { return i; }
        i := i - 1;
    }
}
