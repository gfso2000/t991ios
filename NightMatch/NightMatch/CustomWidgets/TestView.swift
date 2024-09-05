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
        GeometryReader { geometry in
            VStack(spacing:0){
                HStack{
                    ScrollView(.horizontal) {
                        CustomExpressionView(expressionModel: self.expressionModel)
                    }
                }
                .frame(height:geometry.size.height * 0.5)
                .background(Color.blue)
                //.containerRelativeFrame(.vertical, count: 2, span: 1, spacing: 0)
                
                HStack{
                    KeyboardPanel(expressionModel: self.expressionModel)
                }
                .frame(height:geometry.size.height * 0.5)
                .background(Color.yellow)
            }.background(Color.red)
            .frame(height:.infinity)
        }
    }
    init(){
//        var leftModel: SingularTextModel  = SingularTextModel(id:91, text: "L", showCaret:false,isEndChar:false,fontSize: 20)
//        var rightModel: SingularTextModel  = SingularTextModel(id:92, text: "R", showCaret:false,isEndChar:false,fontSize: 20)
//        var leftExpressionModel: ExpressionModel = ExpressionModel(id:93, parentModel: nil, fontSize: 20)
//        leftExpressionModel.children.append(leftModel)
//        leftExpressionModel.lastFocusedChildrenId = 0
//        var rightExpressionModel: ExpressionModel = ExpressionModel(id:94, parentModel: nil, fontSize: 20)
//        rightExpressionModel.children.append(rightModel)
//        rightExpressionModel.lastFocusedChildrenId = 0
//        
//        var fractionModel: FractionModel = FractionModel(id:95, showCaret:false, parentModel:nil)
//        fractionModel.numeratorPartModel = leftExpressionModel
//        fractionModel.denominatorPartModel = rightExpressionModel
//        
//        var singleModel: SingularTextModel  = SingularTextModel(id:96, text: "A", showCaret:false,isEndChar:false,fontSize: 20)
//        
        var expressionContext = ExpressionContext()
        var expressionModel: ExpressionModel = ExpressionModel(expressionContext: expressionContext, id:IdGenerator.generateId(), parentModel: nil, fontSize: 20)
        //        expressionModel.children.append(fractionModel)
        //        expressionModel.children.append(singleModel)
        //        expressionModel.lastFocusedChildrenId = 1
        expressionModel.setFocus(FocusDirectionEnum.ORIGINAL)
        expressionContext.rootExpressionModel = expressionModel
        expressionContext.activeExpressionModelId = expressionModel.id
//        fractionModel.parentModel = expressionModel
//        leftExpressionModel.parentModel = fractionModel
//        rightExpressionModel.parentModel = fractionModel
        
        _expressionModel = StateObject(wrappedValue: expressionModel)
    }
}

#Preview {
    TestView()
}
