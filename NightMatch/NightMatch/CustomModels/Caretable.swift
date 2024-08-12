//
//  Caretable.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import Foundation

protocol Caretable{
    var id:Int { get set }
    var showCaret:Bool { get set }
}

//extension Caretable {
//    static func == (lhs: Self, rhs: Self) -> Bool {
//        return lhs.id == rhs.id
//    }
//}
