//
//  ExpressionModel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import Foundation

class ExpressionModel:ObservableObject{
    @Published var children:[Caretable] = []
    @Published var lastFocusedChildrenId:Int = -1
    
}
