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
                }else if let fractionModel = expressionModel.children[index] as? FractionModel {
                    CustomFractionView(model:fractionModel)
                }else if let methodOneModel = expressionModel.children[index] as? MethodOneModel {
                    CustomMethodOneView(model:methodOneModel)
                }else if let absModel = expressionModel.children[index] as? AbsModel {
                    CustomAbsView(model:absModel)
                }else if let ddxModel = expressionModel.children[index] as? DDXModel {
                    CustomDDXView(model:ddxModel)
                }else if let integralModel = expressionModel.children[index] as? IntegralModel {
                    CustomIntegralView(model:integralModel)
                }else if let logFullModel = expressionModel.children[index] as? LogFullModel {
                    CustomLogFullView(model:logFullModel)
                }else if let logSimpleModel = expressionModel.children[index] as? LogSimpleModel {
                    CustomLogSimpleView(model:logSimpleModel)
                }else if let methodTwoModel = expressionModel.children[index] as? MethodTwoModel {
                    CustomMethodTwoView(model:methodTwoModel)
                }else if let mixedFractionModel = expressionModel.children[index] as? MixedFractionModel {
                    CustomMixedFractionView(model:mixedFractionModel)
                }else if let mixedSquareRootModel = expressionModel.children[index] as? MixedSquareRootModel {
                    CustomMixedSquareRootView(model:mixedSquareRootModel)
                }else if let squareModel = expressionModel.children[index] as? SquareModel {
                    CustomSquareView(model:squareModel)
                }else if let squareRootModel = expressionModel.children[index] as? SquareRootModel {
                    CustomSquareRootView(model:squareRootModel)
                }else if let sumModel = expressionModel.children[index] as? SumModel {
                    CustomSumView(model:sumModel)
                }
            }
            Text(expressionModel.getData().getDataAsQalculate())
                .accessibilityIdentifier(accessibilityIdentifier)
                .frame(width:0,height:0)
        }
    }
}

#Preview {
    let expressionContext = ExpressionContext()
    return CustomExpressionView(accessibilityIdentifier:"a", expressionModel: ExpressionModel(expressionContext:expressionContext, id:1,parentModel: nil,fontSize: 20))
}
