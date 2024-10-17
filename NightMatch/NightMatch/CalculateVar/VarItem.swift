//
//  VarItem.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/10/16.
//

import SwiftUI

struct VarItem: View {
    var varBean: VarBean
    @StateObject var resultModel:ExpressionModel
    let fontSize:CGFloat = 30
    let imageSize:CGFloat = 25
    var selectItem: (String) -> Void
    var resetItem: (String) -> Void
    
    init(varBean: VarBean, selectItem : @escaping (String) -> Void, resetItem : @escaping (String) -> Void) {
        self.varBean = varBean
        let resultModel: ExpressionModel = ExpressionModel(expressionContext: nil, id:CustomIdGenerator.generateId(), parentModel: nil, fontSize: fontSize)
        resultModel.replicate(varBean.getExpressionData())
        //stateful, so that resultView can update
        self._resultModel = StateObject(wrappedValue: resultModel)
        self.selectItem = selectItem
        self.resetItem = resetItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing:0){
                HStack(spacing:0){
                    Text(varBean.varName+" = ").font(.system(size: fontSize))
                    ScrollView(.horizontal) {
                        CustomExpressionView(expressionModel: self.resultModel)
                            .background(Color.blue)
                    }
                    .background(.green)
                }
                Spacer()
                
                HStack(spacing:0){
                    Button(role: .destructive) {
                        resetItem(varBean.varName)
                    } label: {
                        Image(systemName: "clear").resizable()
                            .frame(width:imageSize,height:imageSize)
                    }
                    .buttonStyle(.bordered)
                    
                    Button(role: .destructive) {
                        print("Image tapped!")
                    } label: {
                        Image(systemName: "pencil").resizable()
                            .frame(width:imageSize,height:imageSize)
                    }
                    .buttonStyle(.bordered)
                    
                    Button {
                        selectItem(varBean.varName)
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
    var varBeanA = VarBean(varName: "A", expressionData: expressionData)
    
    return VarItem(varBean: varBeanA, selectItem: {varName in
        print(varName)
    }, resetItem: {varName in
        print(varName)
    })
}
