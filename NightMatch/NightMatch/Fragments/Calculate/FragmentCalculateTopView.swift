//
//  FragmentCalculateView.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/27.
//

import SwiftUI

struct FragmentCalculateTopView: View {
    let fragmentCalculateController: FragmentCalulateController
    
    var expressionContext: ExpressionContext = ExpressionContext()
    @StateObject var expressionModel:ExpressionModel
    
    init(fragmentCalculateController: FragmentCalulateController){
        self.fragmentCalculateController = fragmentCalculateController
        
        let expressionModel: ExpressionModel = ExpressionModel(expressionContext: expressionContext, id:CustomIdGenerator.generateId(), parentModel: nil, fontSize: 20)
        expressionModel.setFocus(FocusDirectionEnum.ORIGINAL)
        expressionContext.rootExpressionModel = expressionModel
        expressionContext.activeExpressionModelId = expressionModel.id
        self._expressionModel = StateObject(wrappedValue: expressionModel)
        
        self.fragmentCalculateController.setExpressionContext(expressionContext)
    }
    
    var body: some View {
        CustomExpressionView(expressionModel: self.expressionModel)
    }
}

#Preview {
    let fragmentCalculateController: FragmentCalulateController = FragmentCalulateController()
    return FragmentCalculateTopView(fragmentCalculateController: fragmentCalculateController)
}
