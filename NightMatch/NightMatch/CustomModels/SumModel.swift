//
//  SumModel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import Foundation

class SumModel: Caretable, ObservableObject, ArrowListener {
    var expressionContext: ExpressionContext?
    var parentModel: ArrowListener?
    var fontSize: CGFloat

    var showCaret: Bool = false
    var id: Int = 0
    var mainPartModel: ExpressionModel
    var topPartModel: ExpressionModel
    var bottomPartModel: ExpressionModel

    init(expressionContext: ExpressionContext?, id: Int, showCaret: Bool, parentModel: ArrowListener?) {
        self.expressionContext = expressionContext
        self.id = id
        self.showCaret = showCaret
        self.parentModel = parentModel
        self.fontSize = parentModel?.fontSize ?? 20
        self.mainPartModel = ExpressionModel(expressionContext: expressionContext, id: CustomIdGenerator.generateId(), parentModel: nil, fontSize: self.fontSize)
        self.topPartModel = ExpressionModel(expressionContext: expressionContext, id: CustomIdGenerator.generateId(), parentModel: nil, fontSize: CGFloat(12))
        self.bottomPartModel = ExpressionModel(expressionContext: expressionContext, id: CustomIdGenerator.generateId(), parentModel: nil, fontSize: CGFloat(12))
        self.mainPartModel.parentModel = self
        self.topPartModel.parentModel = self
        self.bottomPartModel.parentModel = self
    }

    func onLeftArrow() {}
    func onRightArrow() {}
    func onUpArrow() {}
    func onDownArrow() {}
    func onShiftLeftArrow() {}
    func onShiftRightArrow() {}

    func onLeftArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel !== mainPartModel {
            parentModel!.onLeftArrowFromChild(self)
        } else {
            topPartModel.setFocus(FocusDirectionEnum.RIGHT)
        }
    }

    func onRightArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel === mainPartModel {
            parentModel!.onRightArrowFromChild(self)
        } else {
            mainPartModel.setFocus(FocusDirectionEnum.LEFT)
        }
    }

    func onUpArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel === topPartModel {
            parentModel!.onUpArrowFromChild(self)
        } else {
            topPartModel.setFocus(FocusDirectionEnum.RIGHT)
        }
    }

    func onDownArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel === bottomPartModel {
            parentModel!.onDownArrowFromChild(self)
        } else {
            bottomPartModel.setFocus(FocusDirectionEnum.RIGHT)
        }
    }

    func setFocus(_ direction: FocusDirectionEnum) {
        bottomPartModel.setFocus(direction)
    }

    func loseFocus() {
        mainPartModel.loseFocus()
        topPartModel.loseFocus()
        bottomPartModel.loseFocus()
    }

    func handleDeleteFromChild(_ childModel: ArrowListener) {}

    func findExpressionModelById(_ expressionModelId: Int) -> ExpressionModel? {
        if let result = topPartModel.findExpressionModelById(expressionModelId) {
            return result
        }
        if let result = mainPartModel.findExpressionModelById(expressionModelId) {
            return result
        }
        return bottomPartModel.findExpressionModelById(expressionModelId)
    }

    func getData() -> ExpressionItemData {
        return SumData(mainPartData: mainPartModel.getData(), topPartData: topPartModel.getData(), bottomPartData: bottomPartModel.getData(), id: self.id)
    }

    func replicate(_ expressionItemData: ExpressionItemData) {
        if let sumData = expressionItemData as? SumData {
            mainPartModel.replicate(sumData.mainPartData)
            topPartModel.replicate(sumData.topPartData)
            bottomPartModel.replicate(sumData.bottomPartData)
            self.id = sumData.id
        } else {
            fatalError("Not SumData: \(expressionItemData)")
        }
    }

    func initializeNumberExpression(_ expressionData: ExpressionData) {
        mainPartModel.replicate(expressionData)
    }
}
