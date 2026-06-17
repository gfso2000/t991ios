//
//  MixedSquareRootModel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import Foundation

class MixedSquareRootModel: Caretable, ObservableObject, ArrowListener {
    var expressionContext: ExpressionContext?
    var parentModel: ArrowListener?
    var fontSize: CGFloat

    var showCaret: Bool = false
    var id: Int = 0
    var outerPartModel: ExpressionModel
    var innerPartModel: ExpressionModel

    init(expressionContext: ExpressionContext?, id: Int, showCaret: Bool, parentModel: ArrowListener?) {
        self.expressionContext = expressionContext
        self.id = id
        self.showCaret = showCaret
        self.parentModel = parentModel
        self.fontSize = parentModel?.fontSize ?? 20
        self.outerPartModel = ExpressionModel(expressionContext: expressionContext, id: CustomIdGenerator.generateId(), parentModel: nil, fontSize: CGFloat(12))
        self.innerPartModel = ExpressionModel(expressionContext: expressionContext, id: CustomIdGenerator.generateId(), parentModel: nil, fontSize: self.fontSize)
        self.outerPartModel.parentModel = self
        self.innerPartModel.parentModel = self
    }

    func onLeftArrow() {}
    func onRightArrow() {}
    func onUpArrow() {}
    func onDownArrow() {}
    func onShiftLeftArrow() {}
    func onShiftRightArrow() {}

    func onLeftArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel !== outerPartModel {
            outerPartModel.setFocus(FocusDirectionEnum.RIGHT)
        } else {
            parentModel!.onLeftArrowFromChild(self)
        }
    }

    func onRightArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel === outerPartModel {
            innerPartModel.setFocus(FocusDirectionEnum.LEFT)
        } else {
            parentModel!.onRightArrowFromChild(self)
        }
    }

    func onUpArrowFromChild(_ childModel: ArrowListener) {
        parentModel!.onUpArrowFromChild(self)
    }

    func onDownArrowFromChild(_ childModel: ArrowListener) {
        parentModel!.onDownArrowFromChild(self)
    }

    func setFocus(_ direction: FocusDirectionEnum) {
        if direction == FocusDirectionEnum.LEFT {
            outerPartModel.setFocus(FocusDirectionEnum.LEFT)
        } else {
            innerPartModel.setFocus(FocusDirectionEnum.RIGHT)
        }
    }

    func loseFocus() {
        outerPartModel.loseFocus()
        innerPartModel.loseFocus()
    }

    func handleDeleteFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel === innerPartModel {
            outerPartModel.setFocus(FocusDirectionEnum.RIGHT)
            childModel.loseFocus()
        }
    }

    func findExpressionModelById(_ expressionModelId: Int) -> ExpressionModel? {
        if let result = outerPartModel.findExpressionModelById(expressionModelId) {
            return result
        }
        return innerPartModel.findExpressionModelById(expressionModelId)
    }

    func getData() -> ExpressionItemData {
        return MixedSquareRootData(outerPartData: outerPartModel.getData(), innerPartData: innerPartModel.getData(), id: self.id)
    }

    func replicate(_ expressionItemData: ExpressionItemData) {
        if let mixedSquareRootData = expressionItemData as? MixedSquareRootData {
            outerPartModel.replicate(mixedSquareRootData.outerPartData)
            innerPartModel.replicate(mixedSquareRootData.innerPartData)
            self.id = mixedSquareRootData.id
        } else {
            fatalError("Not MixedSquareRootData: \(expressionItemData)")
        }
    }

    func initializeNumberExpression(_ expressionData: ExpressionData) {
        outerPartModel.replicate(expressionData)
    }
}
