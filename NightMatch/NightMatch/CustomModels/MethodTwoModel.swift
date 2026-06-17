//
//  MethodTwoModel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import Foundation

class MethodTwoModel: Caretable, ObservableObject, ArrowListener {
    var expressionContext: ExpressionContext?
    var parentModel: ArrowListener?
    var fontSize: CGFloat

    var showCaret: Bool = false
    var id: Int = 0
    var type: String = ""
    var nPartModel: ExpressionModel
    var rPartModel: ExpressionModel

    init(expressionContext: ExpressionContext?, id: Int, showCaret: Bool, parentModel: ArrowListener?, type: String) {
        self.expressionContext = expressionContext
        self.id = id
        self.type = type
        self.showCaret = showCaret
        self.parentModel = parentModel
        self.fontSize = parentModel?.fontSize ?? 20
        self.nPartModel = ExpressionModel(expressionContext: expressionContext, id: CustomIdGenerator.generateId(), parentModel: nil, fontSize: self.fontSize)
        self.rPartModel = ExpressionModel(expressionContext: expressionContext, id: CustomIdGenerator.generateId(), parentModel: nil, fontSize: self.fontSize)
        self.nPartModel.parentModel = self
        self.rPartModel.parentModel = self
    }

    func onLeftArrow() {}
    func onRightArrow() {}
    func onUpArrow() {}
    func onDownArrow() {}
    func onShiftLeftArrow() {}
    func onShiftRightArrow() {}

    func onLeftArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel !== nPartModel {
            nPartModel.setFocus(FocusDirectionEnum.RIGHT)
        } else {
            parentModel!.onLeftArrowFromChild(self)
        }
    }

    func onRightArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel === nPartModel {
            rPartModel.setFocus(FocusDirectionEnum.LEFT)
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
            nPartModel.setFocus(FocusDirectionEnum.LEFT)
        } else {
            rPartModel.setFocus(FocusDirectionEnum.RIGHT)
        }
    }

    func loseFocus() {
        nPartModel.loseFocus()
        rPartModel.loseFocus()
    }

    func handleDeleteFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel === rPartModel {
            nPartModel.setFocus(FocusDirectionEnum.RIGHT)
            childModel.loseFocus()
        }
    }

    func findExpressionModelById(_ expressionModelId: Int) -> ExpressionModel? {
        if let result = nPartModel.findExpressionModelById(expressionModelId) {
            return result
        }
        return rPartModel.findExpressionModelById(expressionModelId)
    }

    func getData() -> ExpressionItemData {
        return MethodTwoData(nPartData: nPartModel.getData(), rPartData: rPartModel.getData(), id: self.id, type: self.type)
    }

    func replicate(_ expressionItemData: ExpressionItemData) {
        if let methodTwoData = expressionItemData as? MethodTwoData {
            nPartModel.replicate(methodTwoData.nPartData)
            rPartModel.replicate(methodTwoData.rPartData)
            self.id = methodTwoData.id
            self.type = methodTwoData.type
        } else {
            fatalError("Not MethodTwoData: \(expressionItemData)")
        }
    }

    func initializeNumberExpression(_ expressionData: ExpressionData) {
        nPartModel.replicate(expressionData)
    }
}
