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
    let widthPct = 0.8
    let fontSize = 20
    let imageScale = 0.6
    var bgColor : Color
    var buttonStyle : GrowingButtonStyle
    
    init(image:Image, secondText:String, bgColor: Color = Color(red: 54 / 255, green: 54 / 255, blue: 54 / 255), action:@escaping () -> Void){
        self.image = image;
        self.secondText = secondText
        self.bgColor = bgColor
        self.buttonStyle = GrowingButtonStyle(bgColor: self.bgColor)
        self.action = action
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing:0){
                Text(secondText)
                    .frame(width:geometry.size.width*widthPct, height:geometry.size.height * topHeightPct)
                    .font(.system(size: CGFloat(fontSize)))
                    .foregroundColor(Color(red: 102 / 255, green: 204 / 255, blue: 255 / 255))
                Button {
                    action()
                }label: {
                    image.resizable()
                        .frame(width:geometry.size.width*widthPct, height:geometry.size.height * bottomHeightPct)
                        .scaleEffect(CGSize(width: imageScale, height: imageScale))
                }
                .buttonStyle(buttonStyle)
            }
        }
    }
}

#Preview {
    KeyboardButtonImageText(image:Image("custom_button_x10n"),secondText:"FUN", bgColor: Color(red: 102 / 255, green: 204 / 255, blue: 255 / 255), action:{
        print("a")
    })
}
