//
//  KeyboardButton.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/15.
//

import SwiftUI

struct KeyboardButtonTextText: View {
    var text:String
    var secondText:String
    var action:() -> Void
    let topHeightPct = 0.35
    let bottomHeightPct = 0.55
    let widthPct = 0.8
    let fontUpSize = 20
    let fontSize = 24
    
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
            }
        }
    }
}

#Preview {
    KeyboardButtonTextText(text:"Del",secondText:"FUN",action:{
        print("a")
    })
}
