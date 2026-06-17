//
//  CustomSumView.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/12.
//

import SwiftUI

struct CustomSumView: View {
    @ObservedObject var model: SumModel
    @State var isRectangleVisible: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                if isRectangleVisible {
                    Rectangle().frame(width: 1).foregroundColor(.red)
                } else {
                    Rectangle().frame(width: 1).foregroundColor(.clear)
                }
                HStack(alignment: .center, spacing: 0) {
                    VStack(spacing: 0) {
                        CustomExpressionView(accessibilityIdentifier: "NA", expressionModel: model.topPartModel)
                        Text("Σ")
                            .font(.system(size: 24))
                        CustomExpressionView(accessibilityIdentifier: "NA", expressionModel: model.bottomPartModel)
                    }
                    CustomExpressionView(accessibilityIdentifier: "NA", expressionModel: model.mainPartModel)
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
        CustomSumView(model: SumModel(expressionContext: expressionContext, id: 1, showCaret: true, parentModel: ExpressionModel(expressionContext: expressionContext, id: 1, parentModel: nil, fontSize: 20)))
        CustomSumView(model: SumModel(expressionContext: expressionContext, id: 2, showCaret: false, parentModel: ExpressionModel(expressionContext: expressionContext, id: 2, parentModel: nil, fontSize: 20)))
    }
}
