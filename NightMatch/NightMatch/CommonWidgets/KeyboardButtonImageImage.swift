//
//  KeyboardButtonImage.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/9.
//

import SwiftUI

struct KeyboardButtonImageImage: View {
    var imageBottom: Image
    var imageUp: Image
    var action:() -> Void
    let topHeightPct = 0.35
    let bottomHeightPct = 0.55
    let widthPct = 0.8
    let fontSize = 24
    let imageScale = 0.6
    let imageUpScale = 0.8
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing:0){
                imageUp.resizable()
                    .frame(width:geometry.size.width*widthPct, height:geometry.size.height * topHeightPct)
                    .scaleEffect(CGSize(width: imageUpScale, height: imageUpScale))
                Button {
                    action()
                }label: {
                    imageBottom.resizable()
                        .frame(width:geometry.size.width*widthPct, height:geometry.size.height * bottomHeightPct)
                        .scaleEffect(CGSize(width: imageScale, height: imageScale))
                }
                .buttonStyle(GrowingButtonStyle())
            }
        }
    }
}

#Preview {
    KeyboardButtonImageImage(imageBottom:Image("custom_button_x10n"),imageUp:Image("custom_button_x10n"),action:{
        print("a")
    })
}
