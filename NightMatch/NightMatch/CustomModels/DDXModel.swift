//
//  DDXModel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import Foundation

class DDXModel: Caretable, ObservableObject, ArrowListener {
    var expressionContext: ExpressionContext?
    var parentModel: ArrowListener?
    var fontSize: CGFloat

    var showCaret: Bool = false
    var id: Int = 0
    var mainPartModel: ExpressionModel
    var constantPartModel: ExpressionModel

    init(expressionContext: ExpressionContext?, id: Int, showCaret: Bool, parentModel: ArrowListener?) {
        self.expressionContext = expressionContext
        self.id = id
        self.showCaret = showCaret
        self.parentModel = parentModel
        self.fontSize = parentModel?.fontSize ?? 20
        self.mainPartModel = ExpressionModel(expressionContext: expressionContext, id: CustomIdGenerator.generateId(), parentModel: nil, fontSize: self.fontSize)
        self.constantPartModel = ExpressionModel(expressionContext: expressionContext, id: CustomIdGenerator.generateId(), parentModel: nil, fontSize: CGFloat(12))
        self.mainPartModel.parentModel = self
        self.constantPartModel.parentModel = self
    }

    func onLeftArrow() {}
    func onRightArrow() {}
    func onUpArrow() {}
    func onDownArrow() {}
    func onShiftLeftArrow() {}
    func onShiftRightArrow() {}

    func onLeftArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel !== mainPartModel {
            mainPartModel.setFocus(FocusDirectionEnum.RIGHT)
        } else {
            parentModel!.onLeftArrowFromChild(self)
        }
    }

    func onRightArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel === mainPartModel {
            constantPartModel.setFocus(FocusDirectionEnum.LEFT)
        } else {
            parentModel!.onRightArrowFromChild(self)
        }
    }

    func onUpArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel === mainPartModel {
            parentModel!.onUpArrowFromChild(self)
        } else if childModel as? ExpressionModel === constantPartModel {
            mainPartModel.setFocus(FocusDirectionEnum.RIGHT)
        }
    }

    func onDownArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel === mainPartModel {
            constantPartModel.setFocus(FocusDirectionEnum.RIGHT)
        } else if childModel as? ExpressionModel === constantPartModel {
            parentModel!.onDownArrowFromChild(self)
        }
    }

    func setFocus(_ direction: FocusDirectionEnum) {
        if direction == FocusDirectionEnum.LEFT {
            mainPartModel.setFocus(FocusDirectionEnum.LEFT)
        } else {
            constantPartModel.setFocus(FocusDirectionEnum.RIGHT)
        }
    }

    func loseFocus() {
        mainPartModel.loseFocus()
        constantPartModel.loseFocus()
    }

    func handleDeleteFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel === constantPartModel {
            mainPartModel.setFocus(FocusDirectionEnum.RIGHT)
            childModel.loseFocus()
        }
    }

    func findExpressionModelById(_ expressionModelId: Int) -> ExpressionModel? {
        if let result = mainPartModel.findExpressionModelById(expressionModelId) {
            return result
        }
        return constantPartModel.findExpressionModelById(expressionModelId)
    }

    func getData() -> ExpressionItemData {
        return DDXData(mainPartData: mainPartModel.getData(), constantPartData: constantPartModel.getData(), id: self.id)
    }

    func replicate(_ expressionItemData: ExpressionItemData) {
        if let ddxData = expressionItemData as? DDXData {
            mainPartModel.replicate(ddxData.mainPartData)
            constantPartModel.replicate(ddxData.constantPartData)
            self.id = ddxData.id
        } else {
            fatalError("Not DDXData: \(expressionItemData)")
        }
    }

    func initializeNumberExpression(_ expressionData: ExpressionData) {
        mainPartModel.replicate(expressionData)
    }
}
