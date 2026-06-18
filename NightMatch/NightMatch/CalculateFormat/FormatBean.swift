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
    let resultString: String

    init(id: Int, name: String, expressionData: ExpressionData, resultString: String = "") {
        self.id = id
        self.name = name
        self.expressionData = expressionData
        self.resultString = resultString
    }
}
