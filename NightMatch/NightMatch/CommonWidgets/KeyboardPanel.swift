//
//  KeyboardPanel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/14.
//

import SwiftUI

struct KeyboardPanel: View {
    @State private var showingHistory = false
    let btnSpacing:CGFloat = 2
    let expressionContext: ExpressionContext
    let rowWidthPct = 1.0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing:0){
                HStack(spacing:btnSpacing){
                    KeyboardButtonImageText(image: Image("custom_button_onoff"), secondText: "ON/OFF", fontSize:12, imageScale:0.6, action:{
                        showingHistory = true
                    })
                    KeyboardButtonImageText(image: Image("custom_button_main"), secondText: "MAIN", fontSize:16, imageScale:0.6, action:{
                        showingHistory = true
                    })
                    KeyboardButtonImageText(image: Image("custom_button_history"), secondText: "PASTE", fontSize:16, imageScale:0.6, action:{
                        showingHistory = true
                    }).sheet(isPresented: $showingHistory) {
                        HistoryList(rerunItemCallback:rerunItemCallback)
                    }
                    KeyboardButtonImageText(image: Image("custom_button_arrow_up"), secondText: " ", imageScale:0.6, action:{
                        expressionContext.getActiveExpressionModel().onUpArrow()
                    })
                    KeyboardButtonImageText(image: Image("custom_button_undo"), secondText: "UNDO", fontSize:16, imageScale:0.6, action:{
                        expressionContext.onUndo()
                    })
                    KeyboardButtonImageText(image: Image("custom_button_arrow_head"), secondText: " ", imageScale:0.6, action:{
                        showingHistory = true
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonImageText(image: Image("custom_button_set"), secondText: "SET", imageScale:0.6, action:{
                        showingHistory = true
                    })
                    KeyboardButtonImageText(image: Image("custom_button_return"), secondText: " ", imageScale:0.6, action:{
                        showingHistory = true
                    })
                    KeyboardButtonImageText(image: Image("custom_button_arrow_left"), secondText: " ", imageScale:0.6, action:{
                        expressionContext.getActiveExpressionModel().onLeftArrow()
                    })
                    KeyboardButtonTextText(text: "OK", secondText: " ", action:{
                        print("OK");
                    })
                    KeyboardButtonImageText(image: Image("custom_button_arrow_right"), secondText: " ", imageScale:0.5, action:{
                        expressionContext.getActiveExpressionModel().onRightArrow()
                    })
                    KeyboardButtonImageText(image: Image("custom_button_arrow_tail"), secondText: " ", imageScale:0.6, action:{
                        expressionContext.getActiveExpressionModel().onRightArrow()
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonImageText(image: Image("custom_button_shift"), secondText: "SHIFT", fontSize:16, bgColor: Color(red: 102 / 255, green: 204 / 255, blue: 255 / 255), action:{
                        showingHistory = true
                    })
                    KeyboardButtonImageText(image: Image("custom_button_var"), secondText: "VAR", imageScale:1.2, action:{
                        showingHistory = true
                    })
                    KeyboardButtonImageText(image: Image("custom_button_fx"), secondText: "FUN", imageScale:0.6, action:{
                        showingHistory = true
                    })
                    KeyboardButtonImageText(image: Image("custom_button_arrow_down"), secondText: " ", imageScale:0.6, action:{
                        expressionContext.getActiveExpressionModel().onDownArrow()
                    })
                    KeyboardButtonImageText(image: Image("custom_button_cata"), secondText: "CATA", fontSize:16, imageScale:0.6, action:{
                        expressionContext.getActiveExpressionModel().onDownArrow()
                    })
                    KeyboardButtonImageText(image: Image("custom_button_tool"), secondText: "TOOL", fontSize:16, imageScale:0.6, action:{
                        expressionContext.getActiveExpressionModel().onDownArrow()
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextImage(text: "𝑿", image:Image("custom_button_degree"), action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonImageImage(imageBottom:Image("custom_button_fraction"),imageUp:Image("custom_button_mixedfraction"),action:{
                        expressionContext.getActiveExpressionModel().addFraction()
                    })
                    KeyboardButtonImageImage(imageBottom:Image("custom_button_sqrt"),imageUp:Image("custom_button_mixedsqrt"),action:{
                        print("a")
                    })
                    KeyboardButtonImageImage(imageBottom:Image("custom_button_xn"),imageUp:Image("custom_button_x1"),action:{
                        print("a")
                    })
                    KeyboardButtonImageImage(imageBottom:Image("custom_button_x2"),imageUp:Image("custom_button_log"),action:{
                        print("a")
                    })
                    KeyboardButtonImageImage(imageBottom:Image("custom_button_lognm"),imageUp:Image("custom_button_ln"),action:{
                        print("a")
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextImage(text: "(一)", image:Image("custom_button_e"), action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextImage(text: "sin", image:Image("custom_button_sin1"), action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextImage(text: "cos", image:Image("custom_button_cos1"), action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextImage(text: "tan", image:Image("custom_button_tan1"), action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextImage(text: "(", image:Image("custom_button_equal"), action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextImage(text: ")", image:Image("custom_button_comma"), action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "7", secondText: "π", action:{
                        expressionContext.getActiveExpressionModel().addSingularText("7")
                    })
                    KeyboardButtonTextText(text: "8", secondText: "∠", action:{
                        expressionContext.getActiveExpressionModel().addSingularText("8")
                    })
                    KeyboardButtonTextText(text: "9", secondText: "i", action:{
                        expressionContext.getActiveExpressionModel().addSingularText("9")
                    })
                    KeyboardButtonImageText(image: Image("custom_button_delete"), secondText: " ", action:{
                        expressionContext.getActiveExpressionModel().delete()
                    })
                    KeyboardButtonTextText(text: "AC", secondText: " ", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "4", secondText: "A", action:{
                        expressionContext.getActiveExpressionModel().addSingularText("4")
                    })
                    KeyboardButtonTextText(text: "5", secondText: "B", action:{
                        expressionContext.getActiveExpressionModel().addSingularText("5")
                    })
                    KeyboardButtonTextText(text: "6", secondText: "C", action:{
                        expressionContext.getActiveExpressionModel().addSingularText("6")
                    })
                    KeyboardButtonTextImage(text: "×", image:Image("custom_button_int"), action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextImage(text: "÷", image:Image("custom_button_dx"), action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "1", secondText: "D", action:{
                        expressionContext.getActiveExpressionModel().addSingularText("1")
                    })
                    KeyboardButtonTextText(text: "2", secondText: "E", action:{
                        expressionContext.getActiveExpressionModel().addSingularText("2")
                    })
                    KeyboardButtonTextText(text: "3", secondText: "F", action:{
                        expressionContext.getActiveExpressionModel().addSingularText("3")
                    })
                    KeyboardButtonTextText(text: "+", secondText: "nPr", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextText(text: "-", secondText: "nCr", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "0", secondText: "x", action:{
                        expressionContext.getActiveExpressionModel().addSingularText("0")
                    })
                    KeyboardButtonTextText(text: ".", secondText: "y", action:{
                        showingHistory = true
                    })
                    KeyboardButtonImageText(image: Image("custom_button_x10n"), secondText: "z", action:{
                        showingHistory = true
                    })
                    KeyboardButtonTextText(text: ".", secondText: "Ans", action:{
                        showingHistory = true
                    })
                    KeyboardButtonTextText(text: "EXE", secondText: " ", action:{
                        showingHistory = true
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
            }
            .padding(btnSpacing)
            .background(Color(red: 37 / 255, green: 37 / 255, blue: 37 / 255))
        }
    }
    
    func rerunItemCallback(_ id:UUID) -> Void{
        print(id)
    }
}

#Preview {
    let expressionContext = ExpressionContext()
    let expressionModel = ExpressionModel(expressionContext:expressionContext, id: 1, parentModel: nil, fontSize: 20)
    expressionContext.rootExpressionModel = expressionModel
    expressionContext.activeExpressionModelId = expressionModel.id
    
    return KeyboardPanel(expressionContext: expressionContext)
}
