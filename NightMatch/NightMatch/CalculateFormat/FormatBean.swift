//
//  FormatBean.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/10/10.
//

import Foundation

struct FormatBean:Identifiable {
    let id: Int
    let name: String
    let expressionData: ExpressionData
    
    init(id: Int, name: String, expressionData: ExpressionData) {
        self.id = id
        self.name = name
        self.expressionData = expressionData
    }
}
