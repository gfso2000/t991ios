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
            let newChild = SingularTextModel(id: expressionModel.children.count + 1, text: "B", hasFocus:true)
            expressionModel.children.append(newChild)
        }) {
            Text("Add Child")
        }
    }
    init(){
        var leftModel: SingularTextModel  = SingularTextModel(id:1, text: "L", hasFocus: false)
        var rightModel: SingularTextModel  = SingularTextModel(id:2, text: "R", hasFocus: false)
        var leftExpressionModel: ExpressionModel = ExpressionModel()
        leftExpressionModel.children.append(leftModel)
        leftExpressionModel.lastFocusedChildrenId = 0
        var rightExpressionModel: ExpressionModel = ExpressionModel()
        rightExpressionModel.children.append(rightModel)
        rightExpressionModel.lastFocusedChildrenId = 0
        
        var fractionModel: FractionModel = FractionModel(id:3, hasFocus:false, leftModel: leftExpressionModel, rightModel: rightExpressionModel)
        
        var singleModel: SingularTextModel  = SingularTextModel(id:1, text: "A", hasFocus: false)
        var expressionModel: ExpressionModel = ExpressionModel()
        expressionModel.children.append(fractionModel)
        expressionModel.children.append(singleModel)
        expressionModel.lastFocusedChildrenId = 1
        
        _expressionModel = StateObject(wrappedValue: expressionModel)
    }
}

#Preview {
    TestView()
}
