//
//  FractionData.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/5.
//

import Foundation

class FractionData : ExpressionItemData{
    var numeratorPartData: ExpressionData
    var denominatorPartData: ExpressionData
    var id:Int
    
    init(numeratorPartData: ExpressionData, denominatorPartData: ExpressionData, id: Int) {
        self.numeratorPartData = numeratorPartData
        self.denominatorPartData = denominatorPartData
        self.id = id
    }
    
    func getNumeratorPartData() -> ExpressionData {
        return self.numeratorPartData
    }
    
    func getDenominatorPartData() -> ExpressionData {
        return self.denominatorPartData
    }
}
