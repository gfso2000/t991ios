//
//  VarItem.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/10/16.
//

import SwiftUI

struct FunItem: View {
    var funBean: FunBean
    @StateObject var resultModel:ExpressionModel
    let fontSize:CGFloat = 30
    let imageSize:CGFloat = 25
    var selectItem: (String) -> Void
    var resetItem: (String) -> Void
    
    init(funBean: FunBean, selectItem : @escaping (String) -> Void, resetItem : @escaping (String) -> Void) {
        self.funBean = funBean
        let resultModel: ExpressionModel = ExpressionModel(expressionContext: nil, id:CustomIdGenerator.generateId(), parentModel: nil, fontSize: fontSize)
        resultModel.replicate(funBean.getExpressionData())
        //stateful, so that resultView can update
        self._resultModel = StateObject(wrappedValue: resultModel)
        self.selectItem = selectItem
        self.resetItem = resetItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing:0){
                HStack(spacing:0){
                    Text(funBean.funName+"(x) = ").font(.system(size: fontSize))
                    ScrollView(.horizontal) {
                        CustomExpressionView(accessibilityIdentifier: funBean.funName, expressionModel: self.resultModel)
                            .background(Color.blue)
                    }
                    .background(.green)
                }
                Spacer()
                
                HStack(spacing:0){
                    Button(role: .destructive) {
                        resetItem(funBean.funName)
                    } label: {
                        Image(systemName: "clear").resizable()
                            .frame(width:imageSize,height:imageSize)
                    }
                    .buttonStyle(.bordered)
                    
                    Button {
                        resetItem(funBean.funName)
                    } label: {
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width:imageSize,height:imageSize)
                    }
                    .buttonStyle(.bordered)
                    
                    Button {
                        selectItem(funBean.funName)
                    } label: {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width:imageSize,height:imageSize)
                    }
                    .buttonStyle(.bordered)
                }
            }
            .frame(width:geometry.size.width)
        }
    }
}

#Preview {
    let expressionData: ExpressionData = ExpressionData.zeroExpressionData()
    var funBean = FunBean(funName: "f", expressionData: expressionData)
    
    return FunItem(funBean: funBean, selectItem: {varName in
        print(varName)
    }, resetItem: {varName in
        print(varName)
    })
}
