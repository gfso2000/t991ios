//
//  FormatData.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/10/10.
//

import Foundation

class FormatData : ObservableObject {
    @Published var defaultExpressionData:ExpressionData? = nil
    @Published var formatList:[FormatBean] = []
    
}
