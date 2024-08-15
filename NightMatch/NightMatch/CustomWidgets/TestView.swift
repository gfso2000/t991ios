//
//  TestView.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import SwiftUI

struct TestView: View {
    @StateObject var expressionModel:ExpressionModel
    
    var body: some View {
        ScrollView(.horizontal) {
            CustomExpressionView(expressionModel: self.expressionModel)
        }
        KeyboardPanel(expressionModel: self.expressionModel)
    }
    init(){
        var leftModel: SingularTextModel  = SingularTextModel(id:91, text: "L", showCaret:false,isEndChar:false,fontSize: 20)
        var rightModel: SingularTextModel  = SingularTextModel(id:92, text: "R", showCaret:false,isEndChar:false,fontSize: 20)
        var leftExpressionModel: ExpressionModel = ExpressionModel(id:93, parentModel: nil, fontSize: 20)
        leftExpressionModel.children.append(leftModel)
        leftExpressionModel.lastFocusedChildrenId = 0
        var rightExpressionModel: ExpressionModel = ExpressionModel(id:94, parentModel: nil, fontSize: 20)
        rightExpressionModel.children.append(rightModel)
        rightExpressionModel.lastFocusedChildrenId = 0
        
        var fractionModel: FractionModel = FractionModel(id:95, showCaret:false, parentModel:nil)
        fractionModel.numeratorPartModel = leftExpressionModel
        fractionModel.denominatorPartModel = rightExpressionModel
        
        var singleModel: SingularTextModel  = SingularTextModel(id:96, text: "A", showCaret:false,isEndChar:false,fontSize: 20)
        
        var expressionModel: ExpressionModel = ExpressionModel(id:97, parentModel: nil, fontSize: 20)
//        expressionModel.children.append(fractionModel)
//        expressionModel.children.append(singleModel)
//        expressionModel.lastFocusedChildrenId = 1
        expressionModel.setFocus(FocusDirectionEnum.ORIGINAL)
        fractionModel.parentModel = expressionModel
        leftExpressionModel.parentModel = fractionModel
        rightExpressionModel.parentModel = fractionModel
        
        _expressionModel = StateObject(wrappedValue: expressionModel)
    }
}

#Preview {
    TestView()
}
