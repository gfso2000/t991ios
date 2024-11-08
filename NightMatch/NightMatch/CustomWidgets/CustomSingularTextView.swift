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
                if model.text == .DOLLAR{
                    Text("    ").font(.system(size: model.fontSize))
                        .foregroundColor(.black)
                        .frame(height:model.fontSize)
                        .overlay(
                            Rectangle()
                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                                .foregroundColor(.black)
                        )
                    
                }else{
                    Text(model.text.rawValue).font(.system(size: model.fontSize))
                        .foregroundColor(.black)
                        .frame(height:model.fontSize)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(0)
            if isRectangleVisible {
                if model.isEndChar && model.text == .EMPTY{
                    Rectangle().frame(width:1,height: 1).foregroundColor(.red)
                }else{
                    Rectangle().frame(height: 1).foregroundColor(.red)
                }
            }else{
                if model.isEndChar && model.text == .EMPTY{
                    Rectangle().frame(width:1,height: 1).foregroundColor(.clear)
                }else{
                    Rectangle().frame(height: 1).foregroundColor(.clear)
                }
            }
        }
        .fixedSize(horizontal: true, vertical: false)
        .padding(0)
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
        CustomSingularTextView(model:SingularTextModel(id:1, text: .DOLLAR, showCaret: true, isEndChar:true, fontSize:20))
        CustomSingularTextView(model:SingularTextModel(id:1, text: .ZERO, showCaret: true, isEndChar:false, fontSize:20))
        CustomSingularTextView(model:SingularTextModel(id:1, text: .EMPTY, showCaret: true, isEndChar:true, fontSize:20))
    }
    
}
