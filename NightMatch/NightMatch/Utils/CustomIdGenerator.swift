//
//  IdGenerator.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/15.
//

import Foundation

class CustomIdGenerator {
    private static var counter = 0
    
    // Global static method to generate and return the next ID
    static func generateId() -> Int {
        counter += 1
        return counter
    }
}
