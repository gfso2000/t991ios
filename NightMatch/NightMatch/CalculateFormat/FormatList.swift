//
//  HistoryList.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/6.
//

import SwiftUI

struct FormatList: View {
    let formatList:[FormatBean]
    
    var body: some View {
        ScrollView {
            ForEach(formatList) { item in
                FormatItem(formatBean: item)
            }
        }
    }
}

#Preview {
    var expressionItemData:SingularTextData = SingularTextData(id: 1, text: "5")
    var children:[ExpressionItemData] = [expressionItemData]
    let expressionData: ExpressionData = ExpressionData(lastFocusedChildrenId: 1, children: children, id: 2)
    
    var formatBean:FormatBean = FormatBean(id: 3, name: "Decimal", expressionData: expressionData)
    var formatBean2:FormatBean = FormatBean(id: 4, name: "Fraction", expressionData: expressionData)
    let formatList:[FormatBean] = [formatBean,formatBean2]
    return FormatList(formatList:formatList).environment(\.locale, .init(identifier: "zh"))
}
