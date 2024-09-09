//
//  KeyboardButton.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/15.
//

import SwiftUI

struct KeyboardButtonTextImage: View {
    var text:String
    var image:Image
    var action:() -> Void
    let topHeightPct = 0.35
    let bottomHeightPct = 0.55
    let widthPct = 0.9
    let fontSize = 24
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing:0){
                image.resizable()
                    .frame(width:geometry.size.width*widthPct, height:geometry.size.height * topHeightPct)
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
    KeyboardButtonTextImage(text:"Del",image:Image("custom_button_x10n"),action:{
        print("a")
    })
}
