//
//  ShiftListener.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/11/8.
//

import Foundation

protocol ShiftListener {
    func pressShift()
    func resetShift()
    func isShiftPressed()->Bool
}
