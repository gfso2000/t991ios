//
//  LogFullModel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import Foundation

class LogFullModel: Caretable, ObservableObject, ArrowListener {
    var expressionContext: ExpressionContext?
    var parentModel: ArrowListener?
    var fontSize: CGFloat

    var showCaret: Bool = false
    var id: Int = 0
    var bottomPartModel: ExpressionModel
    var topPartModel: ExpressionModel

    init(expressionContext: ExpressionContext?, id: Int, showCaret: Bool, parentModel: ArrowListener?) {
        self.expressionContext = expressionContext
        self.id = id
        self.showCaret = showCaret
        self.parentModel = parentModel
        self.fontSize = parentModel?.fontSize ?? 20
        self.bottomPartModel = ExpressionModel(expressionContext: expressionContext, id: CustomIdGenerator.generateId(), parentModel: nil, fontSize: CGFloat(12))
        self.topPartModel = ExpressionModel(expressionContext: expressionContext, id: CustomIdGenerator.generateId(), parentModel: nil, fontSize: self.fontSize)
        self.bottomPartModel.parentModel = self
        self.topPartModel.parentModel = self
    }

    func onLeftArrow() {}
    func onRightArrow() {}
    func onUpArrow() {}
    func onDownArrow() {}
    func onShiftLeftArrow() {}
    func onShiftRightArrow() {}

    func onLeftArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel !== bottomPartModel {
            bottomPartModel.setFocus(FocusDirectionEnum.RIGHT)
        } else {
            parentModel!.onLeftArrowFromChild(self)
        }
    }

    func onRightArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel === bottomPartModel {
            topPartModel.setFocus(FocusDirectionEnum.LEFT)
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
            bottomPartModel.setFocus(FocusDirectionEnum.LEFT)
        } else {
            topPartModel.setFocus(FocusDirectionEnum.RIGHT)
        }
    }

    func loseFocus() {
        bottomPartModel.loseFocus()
        topPartModel.loseFocus()
    }

    func handleDeleteFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel === topPartModel {
            bottomPartModel.setFocus(FocusDirectionEnum.RIGHT)
            childModel.loseFocus()
        }
    }

    func findExpressionModelById(_ expressionModelId: Int) -> ExpressionModel? {
        if let result = bottomPartModel.findExpressionModelById(expressionModelId) {
            return result
        }
        return topPartModel.findExpressionModelById(expressionModelId)
    }

    func getData() -> ExpressionItemData {
        return LogFullData(bottomPartData: bottomPartModel.getData(), topPartData: topPartModel.getData(), id: self.id)
    }

    func replicate(_ expressionItemData: ExpressionItemData) {
        if let logFullData = expressionItemData as? LogFullData {
            bottomPartModel.replicate(logFullData.bottomPartData)
            topPartModel.replicate(logFullData.topPartData)
            self.id = logFullData.id
        } else {
            fatalError("Not LogFullData: \(expressionItemData)")
        }
    }

    func initializeNumberExpression(_ expressionData: ExpressionData) {
        bottomPartModel.replicate(expressionData)
    }
}
