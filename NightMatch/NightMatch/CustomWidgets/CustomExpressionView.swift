//
//  CustomExpressionView.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import SwiftUI

struct CustomExpressionView: View {
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
        }
    }
}

#Preview {
    var expressionContext = ExpressionContext()
    return CustomExpressionView(expressionModel: ExpressionModel(expressionContext:expressionContext, id:1,parentModel: nil,fontSize: 20))
}
