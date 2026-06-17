//
//  MixedFractionModel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import Foundation

class MixedFractionModel: Caretable, ObservableObject, ArrowListener {
    var expressionContext: ExpressionContext?
    var parentModel: ArrowListener?
    var fontSize: CGFloat

    var showCaret: Bool = false
    var id: Int = 0
    var integerPartModel: ExpressionModel
    var numeratorPartModel: ExpressionModel
    var denominatorPartModel: ExpressionModel

    init(expressionContext: ExpressionContext?, id: Int, showCaret: Bool, parentModel: ArrowListener?) {
        self.expressionContext = expressionContext
        self.id = id
        self.showCaret = showCaret
        self.parentModel = parentModel
        self.fontSize = parentModel?.fontSize ?? 20
        self.integerPartModel = ExpressionModel(expressionContext: expressionContext, id: CustomIdGenerator.generateId(), parentModel: nil, fontSize: self.fontSize)
        self.numeratorPartModel = ExpressionModel(expressionContext: expressionContext, id: CustomIdGenerator.generateId(), parentModel: nil, fontSize: self.fontSize)
        self.denominatorPartModel = ExpressionModel(expressionContext: expressionContext, id: CustomIdGenerator.generateId(), parentModel: nil, fontSize: self.fontSize)
        self.integerPartModel.parentModel = self
        self.numeratorPartModel.parentModel = self
        self.denominatorPartModel.parentModel = self
    }

    func onLeftArrow() {}
    func onRightArrow() {}
    func onUpArrow() {}
    func onDownArrow() {}
    func onShiftLeftArrow() {}
    func onShiftRightArrow() {}

    func onLeftArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel !== integerPartModel {
            integerPartModel.setFocus(FocusDirectionEnum.RIGHT)
        } else {
            parentModel!.onLeftArrowFromChild(self)
        }
    }

    func onRightArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel === integerPartModel {
            numeratorPartModel.setFocus(FocusDirectionEnum.LEFT)
        } else {
            parentModel!.onRightArrowFromChild(self)
        }
    }

    func onUpArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel === integerPartModel || childModel as? ExpressionModel === numeratorPartModel {
            parentModel!.onUpArrowFromChild(self)
        } else {
            numeratorPartModel.setFocus(FocusDirectionEnum.RIGHT)
        }
    }

    func onDownArrowFromChild(_ childModel: ArrowListener) {
        if childModel as? ExpressionModel === integerPartModel || childModel as? ExpressionModel === denominatorPartModel {
            parentModel!.onDownArrowFromChild(self)
        } else {
            denominatorPartModel.setFocus(FocusDirectionEnum.RIGHT)
        }
    }

    func setFocus(_ direction: FocusDirectionEnum) {
        if direction == FocusDirectionEnum.LEFT {
            integerPartModel.setFocus(FocusDirectionEnum.LEFT)
        } else if direction == FocusDirectionEnum.ORIGINAL {
            numeratorPartModel.setFocus(FocusDirectionEnum.LEFT)
        } else {
            denominatorPartModel.setFocus(FocusDirectionEnum.RIGHT)
        }
    }

    func loseFocus() {
        integerPartModel.loseFocus()
        numeratorPartModel.loseFocus()
        denominatorPartModel.loseFocus()
    }

    func handleDeleteFromChild(_ childModel: ArrowListener) {}

    func findExpressionModelById(_ expressionModelId: Int) -> ExpressionModel? {
        if let result = numeratorPartModel.findExpressionModelById(expressionModelId) {
            return result
        }
        if let result = integerPartModel.findExpressionModelById(expressionModelId) {
            return result
        }
        return denominatorPartModel.findExpressionModelById(expressionModelId)
    }

    func getData() -> ExpressionItemData {
        return MixedFractionData(integerPartData: integerPartModel.getData(), numeratorPartData: numeratorPartModel.getData(), denominatorPartData: denominatorPartModel.getData(), id: self.id)
    }

    func replicate(_ expressionItemData: ExpressionItemData) {
        if let mixedFractionData = expressionItemData as? MixedFractionData {
            integerPartModel.replicate(mixedFractionData.integerPartData)
            numeratorPartModel.replicate(mixedFractionData.numeratorPartData)
            denominatorPartModel.replicate(mixedFractionData.denominatorPartData)
            self.id = mixedFractionData.id
        } else {
            fatalError("Not MixedFractionData: \(expressionItemData)")
        }
    }

    func initializeNumberExpression(_ expressionData: ExpressionData) {
        integerPartModel.replicate(expressionData)
    }
}
