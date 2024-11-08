//
//  SingularTextEnum.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/11/8.
//

import Foundation

enum SingularTextEnum:String,CaseIterable {
    case DOLLAR = "$", EMPTY=""
    case ZERO = "0", DOT = ".", ONE = "1",TWO = "2",
         THREE = "3", FOUR = "4", FIVE = "5", SIX = "6",
         SEVEN = "7", EIGHT = "8" , NINE = "9"
    case VAR_A = "A", VAR_B = "B", VAR_C = "C",
         VAR_D = "D", VAR_E = "E", VAR_F = "F",
         VAR_X = "𝑿", VAR_Y = "𝒚", VAR_Z = "𝒛"
    
    static func getEnumCase(by name: String) -> SingularTextEnum? {
        return SingularTextEnum.allCases.first { "\($0)" == name }
    }

}
