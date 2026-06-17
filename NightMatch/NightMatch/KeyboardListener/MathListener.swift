//
//  MathListener.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/27.
//

import Foundation

protocol MathListener {
    func addSingularText(_ text: SingularTextEnum) -> Void
    func addFraction() -> Void
    func addMixedFraction() -> Void
    func addSquareRoot() -> Void
    func addMixedSquareRoot() -> Void
    func addSquare(_ type: Int) -> Void
    func addMultiplySquare() -> Void
    func addLogFull() -> Void
    func addLogSimple(_ type: String) -> Void
    func addMethodWithOneArgument(_ type: String) -> Void
    func addMethodWithTwoArguments(_ type: String) -> Void
    func addDDX() -> Void
    func addIntegral() -> Void
    func addSum() -> Void
    func addAbs() -> Void
}
