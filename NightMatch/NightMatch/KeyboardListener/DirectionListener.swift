//
//  DirectionListener.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/27.
//

import Foundation

protocol DirectionListener {
    func onUpArrow()->Void
    func onDownArrow()->Void
    func onLeftArrow()->Void
    func onRightArrow()->Void
}
