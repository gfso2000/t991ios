//
//  KeyboardPanel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/14.
//

import SwiftUI

struct KeyboardPanel: View {
    let btnSpacing:CGFloat = 5
    @ObservedObject var expressionModel:ExpressionModel
    
    var body: some View {
        VStack(spacing:0){
            HStack(spacing:btnSpacing){
                KeyboardButton(text: "DEL", secondText: "FUN", action:{
                    expressionModel.delete()
                })
                KeyboardButton(text: "⬆︎", secondText: " ", action:{
                    expressionModel.onUpArrow()
                })
                KeyboardButton(text: "Undo", secondText: "撤销", action:{
                    print("Undo");
                })
            }
            HStack(spacing:btnSpacing){
                KeyboardButton(text: "⬅︎", secondText: "向左", action:{
                    expressionModel.onLeftArrow()
                })
                KeyboardButton(text: "OK", secondText: " ", action:{
                    print("OK");
                })
                KeyboardButton(text: "➡︎", secondText: "向右", action:{
                    expressionModel.onRightArrow()
                })
            }
            HStack(spacing:btnSpacing){
                KeyboardButton(text: "X", secondText: " ", action:{
                    expressionModel.addSingularText("A")
                })
                KeyboardButton(text: "⬇︎", secondText: " ", action:{
                    expressionModel.onDownArrow()
                })
                KeyboardButton(text: "X/Y", secondText: "向右", action:{
                    expressionModel.addFraction()
                })
            }
            HStack(spacing:btnSpacing){
                KeyboardButton(text: "AC", secondText: " ", action:{
                    expressionModel.onAC()
                })
            }
        }.padding(btnSpacing)
    }
}

#Preview {
    var expressionContext = ExpressionContext()
    return KeyboardPanel(expressionModel: ExpressionModel(expressionContext:expressionContext, id: 1, parentModel: nil, fontSize: 20))
}
