//
//  CustomSingularTextView.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/8.
//

import SwiftUI

struct CustomSingularTextView: View {    
    @ObservedObject var model:SingularTextModel
    @State var isRectangleVisible: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                if isRectangleVisible {
                    Rectangle().frame(width: 1).foregroundColor(.red)
                }else{
                    Rectangle().frame(width: 1).foregroundColor(.clear)
                }
                if model.text == ""{
                    Text("    ")
                        .foregroundColor(.black)
                        .overlay(
                            Rectangle()
                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                                .foregroundColor(.black)
                        )
                    
                }else{
                    Text(model.text)
                        .foregroundColor(.black)
                }
                
            }
            .fixedSize(horizontal: false, vertical: true)
            if isRectangleVisible {
                Rectangle().frame(height: 1).foregroundColor(.red)
            }else{
                Rectangle().frame(height: 1).foregroundColor(.clear)
            }
        }
        .fixedSize(horizontal: true, vertical: false)
        .background(Color.yellow)
        .onReceive(Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()) { _ in
            if model.showCaret {
                isRectangleVisible.toggle()
            } else {
                isRectangleVisible = false
            }
        }
    }
}

#Preview {
    VStack{
        CustomSingularTextView(model:SingularTextModel(id:1,text:"A",hasFocus: true))
        CustomSingularTextView(model:SingularTextModel(id:1,text:"A",hasFocus: false))
    }
    
}
