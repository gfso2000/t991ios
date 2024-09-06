//
//  CalculateHistoryBean.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/6.
//

import Foundation

struct CalculateHistoryBean : Identifiable {
    let id = UUID()
    let expressionDataJsonStr: String
    let expressionDataLatexStr: String
    let fractionResult: String
    let decimalResult: String
    
    init(expressionDataJsonStr: String, expressionDataLatexStr: String, fractionResult: String, decimalResult: String) {
        self.expressionDataJsonStr = expressionDataJsonStr
        self.expressionDataLatexStr = expressionDataLatexStr
        self.fractionResult = fractionResult
        self.decimalResult = decimalResult
    }
}
