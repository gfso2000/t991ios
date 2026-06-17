//
//  CustomDDXView.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/12.
//

import SwiftUI

struct CustomDDXView: View {
    @ObservedObject var model: DDXModel
    @State var isRectangleVisible: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                if isRectangleVisible {
                    Rectangle().frame(width: 1).foregroundColor(.red)
                } else {
                    Rectangle().frame(width: 1).foregroundColor(.clear)
                }
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Text("d")
                        Rectangle().frame(height: 1).foregroundColor(.black)
                        Text("dx")
                    }
                    Text("(")
                    CustomExpressionView(accessibilityIdentifier: "NA", expressionModel: model.mainPartModel)
                    Text(")")
                    Text("|")
                        .font(.system(size: 12))
                    Text("x=")
                        .font(.system(size: 12))
                    CustomExpressionView(accessibilityIdentifier: "NA", expressionModel: model.constantPartModel)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            if isRectangleVisible {
                Rectangle().frame(height: 1).foregroundColor(.red)
            } else {
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
    let expressionContext = ExpressionContext()
    return VStack {
        CustomDDXView(model: DDXModel(expressionContext: expressionContext, id: 1, showCaret: true, parentModel: ExpressionModel(expressionContext: expressionContext, id: 1, parentModel: nil, fontSize: 20)))
        CustomDDXView(model: DDXModel(expressionContext: expressionContext, id: 2, showCaret: false, parentModel: ExpressionModel(expressionContext: expressionContext, id: 2, parentModel: nil, fontSize: 20)))
    }
}
