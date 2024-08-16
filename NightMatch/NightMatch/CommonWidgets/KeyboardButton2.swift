//
//  KeyboardButton.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/15.
//

import SwiftUI

struct KeyboardButton2: View {
    var text:String
    var secondText:String
    var action:() -> Void
    
    var body: some View {
        VStack(spacing:0){
            Text(secondText)
            Button {
                action()
            }label: {
                Text(text).frame(maxWidth: .infinity)
            }
            .buttonStyle(GrowingButtonStyle2())
        }
    }
}

#Preview {
    KeyboardButton2(text:"Del",secondText:"FUN",action:{
        print("a")
    })
}
