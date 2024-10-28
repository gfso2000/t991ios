//
//  KeyboardButton.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/15.
//

import SwiftUI

struct KeyboardButtonTextText: View {
    let text:String
    let secondText:String
    let action:() -> Void
    let topHeightPct = 0.35
    let bottomHeightPct = 0.55
    let widthPct = 0.8
    let fontUpSize = 20
    let fontSize = 24
    let accessibilityIdentifier:String
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing:0){
                Text(secondText)
                    .frame(width:geometry.size.width*widthPct, height:geometry.size.height * topHeightPct)
                    .font(.system(size: CGFloat(fontUpSize)))
                    .foregroundColor(Color(red: 102 / 255, green: 204 / 255, blue: 255 / 255))
                Button {
                    action()
                }label: {
                    Text(text)
                        .frame(width:geometry.size.width*widthPct, height:geometry.size.height * bottomHeightPct)
                        .font(.system(size: CGFloat(fontSize)))
                }
                .buttonStyle(GrowingButtonStyle())
                .accessibilityIdentifier(accessibilityIdentifier)
            }
        }
    }
}

#Preview {
    KeyboardButtonTextText(text:"Del",secondText:"FUN",action:{
        print("a")
    },accessibilityIdentifier:"a")
}
