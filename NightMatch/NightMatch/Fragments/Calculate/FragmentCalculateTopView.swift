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
    
    @EnvironmentObject var activeFragment:ActiveFragment
    
    init(fragmentCalculateController: FragmentCalulateController){
        self.fragmentCalculateController = fragmentCalculateController
        
        let expressionModel: ExpressionModel = ExpressionModel(expressionContext: expressionContext, id:CustomIdGenerator.generateId(), parentModel: nil, fontSize: 20)
        expressionModel.setFocus(FocusDirectionEnum.ORIGINAL)
        expressionContext.rootExpressionModel = expressionModel
        expressionContext.activeExpressionModelId = expressionModel.id
        //stateful, so that expressionView can update
        self._expressionModel = StateObject(wrappedValue: expressionModel)
        
        let resultModel: ExpressionModel = ExpressionModel(expressionContext: nil, id:CustomIdGenerator.generateId(), parentModel: nil, fontSize: 16)
        //stateful, so that resultView can update
        self._resultModel = StateObject(wrappedValue: resultModel)

//        //pass context,resultModel to controller, let controller operate them, and they in turn update view
//        self.fragmentCalculateController.setExpressionContext(expressionContext)
//        self.fragmentCalculateController.setResultModel(self.resultModel)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing:0){
                HStack{
                    ScrollView(.vertical) {
                        ScrollView(.horizontal) {
                            CustomExpressionView(accessibilityIdentifier: TopViewIdentifiers.expressionView, expressionModel: self.expressionModel)
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
                                        CustomExpressionView(accessibilityIdentifier: TopViewIdentifiers.resultView, expressionModel: self.resultModel)
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
            .onAppear(){
                //environmentObject can't be visited in init(), so visit here
                fragmentCalculateController.setActiveFragmentObject(activeFragment)
                
                //pass context,resultModel to controller, let controller operate them, and they in turn update view
                self.fragmentCalculateController.setExpressionContext(expressionContext)
                self.fragmentCalculateController.setResultModel(self.resultModel)
            }
        }
    }
}

#Preview {
    let fragmentCalculateController: FragmentCalulateController = FragmentCalulateController()
    return FragmentCalculateTopView(fragmentCalculateController: fragmentCalculateController).environmentObject(ActiveFragment())
}
