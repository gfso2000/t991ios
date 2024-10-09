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
    @StateObject var resultModel:ExpressionModel
    
    init(fragmentCalculateController: FragmentCalulateController){
        self.fragmentCalculateController = fragmentCalculateController
        
        let expressionModel: ExpressionModel = ExpressionModel(expressionContext: expressionContext, id:CustomIdGenerator.generateId(), parentModel: nil, fontSize: 20)
        expressionModel.setFocus(FocusDirectionEnum.ORIGINAL)
        expressionContext.rootExpressionModel = expressionModel
        expressionContext.activeExpressionModelId = expressionModel.id
        self._expressionModel = StateObject(wrappedValue: expressionModel)
        
        self.fragmentCalculateController.setExpressionContext(expressionContext)
        //todo, change to readonly result model
        self.fragmentCalculateController.setModel(expressionModel)
        
        let resultModel: ExpressionModel = ExpressionModel(expressionContext: nil, id:CustomIdGenerator.generateId(), parentModel: nil, fontSize: 16)
        self._resultModel = StateObject(wrappedValue: resultModel)
        
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing:0){
                HStack{
                    ScrollView(.vertical) {
                        ScrollView(.horizontal) {
                            CustomExpressionView(expressionModel: self.expressionModel)
                                //.frame(maxWidth: .infinity, maxHeight:.infinity, alignment: .leading)
                                .background(Color.red)
                        }
                    }
                    .background(Color.green)
                }
                //always use stack to get a fixed width/height, then set stack's child to scrollView
                .frame(height:geometry.size.height * 0.7)
                
                HStack{
                    GeometryReader { proxy in
                        //scrollView auto fill parent(HStack)
                        ScrollView(.vertical) {
                            ScrollView(.horizontal) {
                                VStack(spacing: 0) {
                                    Spacer()
                                    HStack(spacing: 0) {
                                        Spacer()
                                        //todo, change to resultModel
                                        CustomExpressionView(expressionModel: self.expressionModel)
                                            .background(Color.blue)
                                    }
                                }
                                //make VStack match scrollView width/height by minWidth/minHeight, because width/height will increase to show scrollBar
                                .frame(minWidth: proxy.size.width, minHeight: proxy.size.height)
                            }
                        }.background(Color.black)
                    }
                }
                .frame(height:geometry.size.height * 0.3)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green)
        }
    }
}

#Preview {
    let fragmentCalculateController: FragmentCalulateController = FragmentCalulateController()
    return FragmentCalculateTopView(fragmentCalculateController: fragmentCalculateController)
}
