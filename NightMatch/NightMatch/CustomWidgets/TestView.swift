//
//  TestView.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import SwiftUI

struct TestView: View {
    var expressionContext: ExpressionContext = ExpressionContext()
    @StateObject var expressionModel:ExpressionModel
    
    init(){
        let expressionModel: ExpressionModel = ExpressionModel(expressionContext: expressionContext, id:CustomIdGenerator.generateId(), parentModel: nil, fontSize: 20)
        expressionModel.setFocus(FocusDirectionEnum.ORIGINAL)
        expressionContext.rootExpressionModel = expressionModel
        expressionContext.activeExpressionModelId = expressionModel.id
        self._expressionModel = StateObject(wrappedValue: expressionModel)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing:0){
                HStack{
                    ScrollView(.vertical) {
                        ScrollView(.horizontal) {
                            CustomExpressionView(expressionModel: self.expressionModel)
                        }
                    }
                }
                .frame(height:geometry.size.height * 0.2)
                .background(Color.blue)
                
                HStack{
                    KeyboardPanel(expressionContext: self.expressionContext)
                }
                .frame(height:geometry.size.height * 0.8)
                .background(Color.yellow)
            }.background(Color.red)
        }
    }
}

#Preview {
    TestView()
}
