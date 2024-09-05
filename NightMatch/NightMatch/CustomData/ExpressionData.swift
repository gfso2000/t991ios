//
//  ExpressionData.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/5.
//

import Foundation

class ExpressionData {
    var lastFocusedChildrenId:Int
    var children:[ExpressionItemData]
    var id:Int
    
    init(lastFocusedChildrenId: Int, children: [ExpressionItemData], id: Int) {
        self.lastFocusedChildrenId = lastFocusedChildrenId
        self.children = children
        self.id = id
    }
    
}
