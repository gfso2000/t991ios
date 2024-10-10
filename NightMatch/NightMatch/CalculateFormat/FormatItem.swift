//
//  HistoryItem.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/6.
//

import SwiftUI

struct FormatItem: View {
    var formatBean:FormatBean
    let resultModel: ExpressionModel = ExpressionModel(expressionContext: nil, id:CustomIdGenerator.generateId(), parentModel: nil, fontSize: 16)
    
    init(formatBean:FormatBean){
        self.formatBean = formatBean
        resultModel.replicate(formatBean.expressionData)
    }
    var body: some View {
        //GeometryReader { geometry3 in
            VStack(spacing:0){
//                Text(formatBean.name)
//                    //.frame(width: geometry3.size.width / 1)
//                    .background(Color.green)
                GroupBox(formatBean.name) {
                    CustomExpressionView(expressionModel: self.resultModel)
                        .background(Color.blue)
                }
            }
        //}
    }
}

#Preview {
    var expressionItemData:SingularTextData = SingularTextData(id: 1, text: "5")
    var children:[ExpressionItemData] = [expressionItemData]
    let expressionData: ExpressionData = ExpressionData(lastFocusedChildrenId: 1, children: children, id: 2)
    
    var formatBean:FormatBean = FormatBean(id: 3, name: "Decimal", expressionData: expressionData)
    return FormatItem(formatBean: formatBean)
}
