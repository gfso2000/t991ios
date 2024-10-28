//
//  CustomExpressionView.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import SwiftUI

struct CustomExpressionView: View {
    let accessibilityIdentifier:String
    @ObservedObject var expressionModel:ExpressionModel
    
    var body: some View {
        HStack(spacing:0){
            ForEach(expressionModel.children.indices, id: \.self) { index in
                if let singularTextModel = expressionModel.children[index] as? SingularTextModel {
                    CustomSingularTextView(model:singularTextModel)
                }
                else if let fractionModel = expressionModel.children[index] as? FractionModel {
                    CustomFractionView(model:fractionModel)
                }
            }
            Text(expressionModel.getData().getDataAsQalculate())
                .accessibilityIdentifier(accessibilityIdentifier)
                .frame(width:0,height:0)
        }
//        .accessibilityIdentifier(accessibilityIdentifier)
//        .accessibilityValue(expressionModel.getData().getDataAsQalculate())
    }
}

#Preview {
    let expressionContext = ExpressionContext()
    return CustomExpressionView(accessibilityIdentifier:"a", expressionModel: ExpressionModel(expressionContext:expressionContext, id:1,parentModel: nil,fontSize: 20))
}
