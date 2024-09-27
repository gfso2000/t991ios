//
//  HistoryListener.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/27.
//

import Foundation

protocol HistoryListener {
    func showHistory()->Bool
    func rerun(_ expression:String) -> Void
}
