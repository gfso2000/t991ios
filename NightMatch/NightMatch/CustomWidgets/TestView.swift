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
        CustomExpressionView(expressionModel: self.expressionModel)
        Button(action: {
            // Add a new child to expressionModel
            let newChild = SingularTextModel(id: expressionModel.children.count + 1, text: "B", showCaret:true,isEndChar:false,fontSize: 20)
            expressionModel.children.append(newChild)
        }) {
            Text("Add Child")
        }
        KeyboardPanel()
    }
    init(){
        var leftModel: SingularTextModel  = SingularTextModel(id:1, text: "L", showCaret:false,isEndChar:false,fontSize: 20)
        var rightModel: SingularTextModel  = SingularTextModel(id:2, text: "R", showCaret:false,isEndChar:false,fontSize: 20)
        var leftExpressionModel: ExpressionModel = ExpressionModel(id:3, parentModel: nil, fontSize: 20)
        leftExpressionModel.children.append(leftModel)
        leftExpressionModel.lastFocusedChildrenId = 0
        var rightExpressionModel: ExpressionModel = ExpressionModel(id:4, parentModel: nil, fontSize: 20)
        rightExpressionModel.children.append(rightModel)
        rightExpressionModel.lastFocusedChildrenId = 0
        
        var fractionModel: FractionModel = FractionModel(id:5, showCaret:false, parentModel:nil)
        fractionModel.numeratorPartModel = leftExpressionModel
        fractionModel.denominatorPartModel = rightExpressionModel
        
        var singleModel: SingularTextModel  = SingularTextModel(id:6, text: "A", showCaret:false,isEndChar:false,fontSize: 20)
        
        var expressionModel: ExpressionModel = ExpressionModel(id:7, parentModel: nil, fontSize: 20)
        expressionModel.children.append(fractionModel)
        expressionModel.children.append(singleModel)
        expressionModel.lastFocusedChildrenId = 1
        
        fractionModel.parentModel = expressionModel
        leftExpressionModel.parentModel = fractionModel
        rightExpressionModel.parentModel = fractionModel
        
        _expressionModel = StateObject(wrappedValue: expressionModel)
    }
}

#Preview {
    TestView()
}
