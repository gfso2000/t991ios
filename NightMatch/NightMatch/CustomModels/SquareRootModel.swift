//
//  SquareRootModel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import Foundation

class SquareRootModel: Caretable, ObservableObject, ArrowListener {
    var expressionContext: ExpressionContext?
    var parentModel: ArrowListener?
    var fontSize: CGFloat

    var showCaret: Bool = false
    var id: Int = 0
    var innerPartModel: ExpressionModel

    init(expressionContext: ExpressionContext?, id: Int, showCaret: Bool, parentModel: ArrowListener?) {
        self.expressionContext = expressionContext
        self.id = id
        self.showCaret = showCaret
        self.parentModel = parentModel
        self.fontSize = parentModel?.fontSize ?? 20
        self.innerPartModel = ExpressionModel(expressionContext: expressionContext, id: CustomIdGenerator.generateId(), parentModel: nil, fontSize: self.fontSize)
        self.innerPartModel.parentModel = self
    }

    func onLeftArrow() {}
    func onRightArrow() {}
    func onUpArrow() {}
    func onDownArrow() {}
    func onShiftLeftArrow() {}
    func onShiftRightArrow() {}

    func onLeftArrowFromChild(_ childModel: ArrowListener) {
        parentModel!.onLeftArrowFromChild(self)
    }

    func onRightArrowFromChild(_ childModel: ArrowListener) {
        parentModel!.onRightArrowFromChild(self)
    }

    func onUpArrowFromChild(_ childModel: ArrowListener) {
        parentModel!.onUpArrowFromChild(self)
    }

    func onDownArrowFromChild(_ childModel: ArrowListener) {
        parentModel!.onDownArrowFromChild(self)
    }

    func setFocus(_ direction: FocusDirectionEnum) {
        innerPartModel.setFocus(direction)
    }

    func loseFocus() {
        innerPartModel.loseFocus()
    }

    func handleDeleteFromChild(_ childModel: ArrowListener) {}

    func findExpressionModelById(_ expressionModelId: Int) -> ExpressionModel? {
        return innerPartModel.findExpressionModelById(expressionModelId)
    }

    func getData() -> ExpressionItemData {
        return SquareRootData(innerPartData: innerPartModel.getData(), id: self.id)
    }

    func replicate(_ expressionItemData: ExpressionItemData) {
        if let squareRootData = expressionItemData as? SquareRootData {
            innerPartModel.replicate(squareRootData.innerPartData)
            self.id = squareRootData.id
        } else {
            fatalError("Not SquareRootData: \(expressionItemData)")
        }
    }

    func initializeNumberExpression(_ expressionData: ExpressionData) {
        innerPartModel.replicate(expressionData)
    }
}
