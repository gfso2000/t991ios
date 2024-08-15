//
//  KeyboardPanel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/14.
//

import SwiftUI

struct KeyboardPanel: View {
    let btnSpacing:CGFloat = 5
    var body: some View {
        VStack(spacing:0){
            HStack(spacing:btnSpacing){
                KeyboardButton(text: "DEL", secondText: "FUN", action:{
                    print("DEL");
                })
                KeyboardButton(text: "⬆︎", secondText: " ", action:{
                    print("⬆︎");
                })
                KeyboardButton(text: "Undo", secondText: "撤销", action:{
                    print("Undo");
                })
            }
            HStack(spacing:btnSpacing){
                KeyboardButton(text: "⬅︎", secondText: "向左", action:{
                    print("⬅︎");
                })
                KeyboardButton(text: "OK", secondText: " ", action:{
                    print("OK");
                })
                KeyboardButton(text: "➡︎", secondText: "向右", action:{
                    print("➡︎");
                })
            }
            HStack(spacing:btnSpacing){
                KeyboardButton(text: "X", secondText: " ", action:{
                    print("X");
                })
                KeyboardButton(text: "⬇︎", secondText: " ", action:{
                    print("⬇︎");
                })
                KeyboardButton(text: "X", secondText: "向右", action:{
                    print("X");
                })
            }
        }.padding(btnSpacing)
    }
}

#Preview {
    KeyboardPanel()
}
