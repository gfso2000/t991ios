//
//  CustomMixedFractionView.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/12.
//

import SwiftUI

struct CustomMixedFractionView: View {
    @ObservedObject var model: MixedFractionModel
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
                    CustomExpressionView(accessibilityIdentifier: "NA", expressionModel: model.integerPartModel)
                    VStack(spacing: 0) {
                        CustomExpressionView(accessibilityIdentifier: "NA", expressionModel: model.numeratorPartModel)
                        Rectangle().frame(height: 1).foregroundColor(.black)
                        CustomExpressionView(accessibilityIdentifier: "NA", expressionModel: model.denominatorPartModel)
                    }
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
        CustomMixedFractionView(model: MixedFractionModel(expressionContext: expressionContext, id: 1, showCaret: true, parentModel: ExpressionModel(expressionContext: expressionContext, id: 1, parentModel: nil, fontSize: 20)))
        CustomMixedFractionView(model: MixedFractionModel(expressionContext: expressionContext, id: 2, showCaret: false, parentModel: ExpressionModel(expressionContext: expressionContext, id: 2, parentModel: nil, fontSize: 20)))
    }
}
