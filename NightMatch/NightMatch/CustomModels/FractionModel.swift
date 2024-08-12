//
//  FractionModel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import Foundation

class FractionModel:Caretable,ObservableObject{
    var hasFocus: Bool = false
    var id:Int = 0
    var leftModel:ExpressionModel = ExpressionModel()
    var rightModel:ExpressionModel = ExpressionModel()
    
    init(id: Int, hasFocus: Bool, leftModel: ExpressionModel, rightModel: ExpressionModel) {
        self.id = id
        self.hasFocus = hasFocus
        self.leftModel = leftModel
        self.rightModel = rightModel
    }
}
