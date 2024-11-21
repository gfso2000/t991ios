//
//  FractionModel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import Foundation

class MethodOneModel:Caretable,ObservableObject,ArrowListener{
    var expressionContext: ExpressionContext?
    var parentModel: ArrowListener?
    var fontSize: CGFloat
    
    var showCaret: Bool = false
    var id:Int = 0
    var type:String = ""
    var innerPartModel:ExpressionModel
    
    init(expressionContext:ExpressionContext?, id: Int, showCaret: Bool, parentModel: ArrowListener?, type:String) {
        self.expressionContext = expressionContext
        self.id = id
        self.type = type
        self.showCaret = showCaret
        self.parentModel = parentModel
        self.fontSize = parentModel?.fontSize ?? 20
        self.innerPartModel = ExpressionModel(expressionContext: expressionContext, id:CustomIdGenerator.generateId(), parentModel:nil, fontSize:self.fontSize)
        self.innerPartModel.parentModel = self
    }
    
    func onLeftArrow() {
        
    }
    
    func onRightArrow() {
        
    }
    
    func onUpArrow() {
        
    }
    
    func onDownArrow() {
        
    }
    
    func onShiftLeftArrow() {
        
    }
    
    func onShiftRightArrow() {
        
    }
    
    func onLeftArrowFromChild(_ childModel: any ArrowListener) {
        parentModel!.onLeftArrowFromChild(self)
    }
    
    func onRightArrowFromChild(_ childModel: any ArrowListener) {
        parentModel!.onRightArrowFromChild(self)
    }
    
    func onUpArrowFromChild(_ childModel: ArrowListener) {
        parentModel!.onUpArrowFromChild(self)
    }
    
    func onDownArrowFromChild(_ childModel: any ArrowListener) {
        parentModel!.onDownArrowFromChild(self)
    }
    
    func setFocus(_ direction: FocusDirectionEnum) {
        innerPartModel.setFocus(direction)
    }
    
    func loseFocus() {
        innerPartModel.loseFocus()
    }
    
    func handleDeleteFromChild(_ childModel: any ArrowListener) {
        
    }
    
    func findExpressionModelById(_ expressionModelId: Int) -> ExpressionModel? {
        return innerPartModel.findExpressionModelById(expressionModelId)
    }
    
    func getData() -> ExpressionItemData {
        return MethodOneData(innerPartData:innerPartModel.getData(), id:self.id, type:self.type)
    }
    
    func replicate(_ expressionItemData: ExpressionItemData) {
        if let methodOneData = expressionItemData as? MethodOneData {
            innerPartModel.replicate(methodOneData.innerPartData);
            self.id = methodOneData.id
            self.type = methodOneData.type
        } else {
            fatalError("Not FractionData: \(expressionItemData)")
        }
    }
    func initializeNumberExpression(_ expressionData:ExpressionData) {
        innerPartModel.replicate(expressionData)
    }
}
