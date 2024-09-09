//
//  KeyboardButtonImage.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/9.
//

import SwiftUI

struct KeyboardButtonImageText: View {
    var image: Image
    var secondText:String
    var action:() -> Void
    let topHeightPct = 0.35
    let bottomHeightPct = 0.55
    let widthPct = 0.9
    let fontSize = 24
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing:0){
                Text(secondText)
                    .frame(width:geometry.size.width*widthPct, height:geometry.size.height * topHeightPct)
                    .font(.system(size: CGFloat(fontSize)))
                Button {
                    action()
                }label: {
                    image.resizable()
                        .frame(width:geometry.size.width*widthPct, height:geometry.size.height * bottomHeightPct)
                }
                .buttonStyle(GrowingButtonStyle())
            }
        }
    }
}

#Preview {
    KeyboardButtonImageText(image:Image("custom_button_x10n"),secondText:"FUN",action:{
        print("a")
    })
}
