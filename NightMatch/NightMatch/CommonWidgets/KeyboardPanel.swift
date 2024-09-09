//
//  KeyboardPanel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/14.
//

import SwiftUI

struct KeyboardPanel: View {
    @State private var showingHistory = false
    let btnSpacing:CGFloat = 5
    let expressionContext: ExpressionContext
    
    var body: some View {
        VStack(spacing:0){
            HStack(spacing:btnSpacing){
                KeyboardButton(text: "DEL", secondText: "FUN", action:{
                    expressionContext.getActiveExpressionModel().delete()
                })
                KeyboardButton(text: "⬆︎", secondText: " ", action:{
                    expressionContext.getActiveExpressionModel().onUpArrow()
                })
                KeyboardButton(text: "Undo", secondText: "撤销", action:{
                    expressionContext.onUndo()
                })
            }
            HStack(spacing:btnSpacing){
                KeyboardButton(text: "⬅︎", secondText: "向左", action:{
                    expressionContext.getActiveExpressionModel().onLeftArrow()
                })
                KeyboardButton(text: "OK", secondText: " ", action:{
                    print("OK");
                })
                KeyboardButton(text: "➡︎", secondText: "向右", action:{
                    expressionContext.getActiveExpressionModel().onRightArrow()
                })
            }
            HStack(spacing:btnSpacing){
                KeyboardButton(text: "X", secondText: " ", action:{
                    expressionContext.getActiveExpressionModel().addSingularText("A")
                })
                KeyboardButton(text: "⬇︎", secondText: " ", action:{
                    expressionContext.getActiveExpressionModel().onDownArrow()
                })
                KeyboardButton(text: "X/Y", secondText: " ", action:{
                    expressionContext.getActiveExpressionModel().addFraction()
                })
            }
            HStack(spacing:btnSpacing){
                KeyboardButton(text: "AC", secondText: " ", action:{
                    expressionContext.rootExpressionModel!.onAC()
                })
                KeyboardButton(text: "History", secondText: " ", action:{
                    showingHistory = true
                }).sheet(isPresented: $showingHistory) {
                    HistoryList(rerunItemCallback:rerunItemCallback)
                }
                
            }
        }.padding(btnSpacing)
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
