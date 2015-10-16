//
//  pipe-in.swift
//  Pipe-In
//
//  Created by Garet McKinley on 1/22/15.
//  Copyright (c) 2015 mediachicken. All rights reserved.
//

import Foundation

/*
* The >|< (pipe-in/PIN) operator will check if the right value
* (haystack) contains the left value (needle).
* written .by Garet McKinley (github.com/mediachicken)
*/
infix operator >|< { precedence 50 associativity left }

/*
public func >|<<T,U>(lhs:T,rhs:U) -> T! {
    fatalError("Error!")
}
*/
// handle searching a hashable value in an array
public func >|<<T:Hashable>(lhs:T, rhs:[T]) -> Bool {
    // check if the rhs array contains the lhs hashable value
    if rhs.contains(lhs) {
        return true
    }
    return false
}


public func >|<<K:Hashable,V>(lhs:K, rhs:[K:V]) -> Bool {
    // check if the rhs dict contains a key equal to the lhs hashable value
    if let _ = rhs[lhs] {
        return true
    }
    return false
}

public func >|<<T:Hashable>(lhs:[T], rhs:[T]) -> Bool {
    var flags = 0
    for needle in lhs {
        if needle >|< rhs {
            ++flags
        }
    }
    if flags > 0 { return false }
    return true
}

public func >|<<T:Hashable>(lhs:T, rhs:String) -> Bool {
    if let _ = rhs.rangeOfString(String(lhs)) {
        return true
    }
    return false
}
