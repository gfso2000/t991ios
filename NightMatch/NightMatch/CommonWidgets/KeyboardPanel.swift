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
    let rowWidthPct = 0.98
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing:0){
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "DEL", secondText: "FUN", action:{
                        expressionContext.getActiveExpressionModel().delete()
                    })
                    KeyboardButtonTextText(text: "⬆︎", secondText: " ", action:{
                        expressionContext.getActiveExpressionModel().onUpArrow()
                    })
                    KeyboardButtonTextText(text: "Undo", secondText: "撤销", action:{
                        expressionContext.onUndo()
                    })
                    KeyboardButtonTextText(text: "Undo", secondText: "撤销", action:{
                        expressionContext.onUndo()
                    })
                    KeyboardButtonTextText(text: "Undo", secondText: "撤销", action:{
                        expressionContext.onUndo()
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "⬅︎", secondText: "向左", action:{
                        expressionContext.getActiveExpressionModel().onLeftArrow()
                    })
                    KeyboardButtonTextText(text: "OK", secondText: " ", action:{
                        print("OK");
                    })
                    KeyboardButtonTextText(text: "➡︎", secondText: "向右", action:{
                        expressionContext.getActiveExpressionModel().onRightArrow()
                    })
                    KeyboardButtonTextText(text: "➡︎", secondText: "向右", action:{
                        expressionContext.getActiveExpressionModel().onRightArrow()
                    })
                    KeyboardButtonTextText(text: "➡︎", secondText: "向右", action:{
                        expressionContext.getActiveExpressionModel().onRightArrow()
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "X", secondText: " ", action:{
                        expressionContext.getActiveExpressionModel().addSingularText("A")
                    })
                    KeyboardButtonTextText(text: "⬇︎", secondText: " ", action:{
                        expressionContext.getActiveExpressionModel().onDownArrow()
                    })
                    KeyboardButtonTextText(text: "X/Y", secondText: " ", action:{
                        expressionContext.getActiveExpressionModel().addFraction()
                    })
                    KeyboardButtonTextText(text: "➡︎", secondText: "向右", action:{
                        expressionContext.getActiveExpressionModel().onRightArrow()
                    })
                    KeyboardButtonTextText(text: "➡︎", secondText: "向右", action:{
                        expressionContext.getActiveExpressionModel().onRightArrow()
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "AC", secondText: " ", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextText(text: "History", secondText: " ", action:{
                        showingHistory = true
                    }).sheet(isPresented: $showingHistory) {
                        HistoryList(rerunItemCallback:rerunItemCallback)
                    }
                    KeyboardButtonTextText(text: "AC", secondText: " ", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextText(text: "AC", secondText: " ", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextText(text: "AC", secondText: " ", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "AC", secondText: " ", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextText(text: "History", secondText: " ", action:{
                        showingHistory = true
                    })
                    KeyboardButtonTextText(text: "AC", secondText: " ", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextText(text: "AC", secondText: " ", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextText(text: "AC", secondText: " ", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "AC", secondText: " ", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextText(text: "History", secondText: " ", action:{
                        showingHistory = true
                    })
                    KeyboardButtonTextText(text: "AC", secondText: " ", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextText(text: "AC", secondText: " ", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextText(text: "AC", secondText: " ", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "4", secondText: "A", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextText(text: "5", secondText: "B", action:{
                        showingHistory = true
                    })
                    KeyboardButtonTextText(text: "6", secondText: "C", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextImage(text: "×", image:Image("custom_button_x10n"), action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextText(text: "÷", secondText: " ", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "1", secondText: "D", action:{
                        expressionContext.rootExpressionModel!.onAC()
                    })
                    KeyboardButtonTextText(text: "2", secondText: "E", action:{
                        showingHistory = true
                    })
                    KeyboardButtonTextText(text: "3", secondText: "F", action:{
                        expressionContext.rootExpressionModel!.onAC()
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
                        expressionContext.rootExpressionModel!.onAC()
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
            .background(Color(red: 102 / 255, green: 204 / 255, blue: 255 / 255))
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
