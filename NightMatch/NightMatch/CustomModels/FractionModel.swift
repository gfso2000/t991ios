//
//  FractionModel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import Foundation

class FractionModel:Caretable,ObservableObject,ArrowListener{
    var parentModel: ArrowListener?
    var fontSize: CGFloat
    
    var showCaret: Bool = false
    var id:Int = 0
    var numeratorPartModel:ExpressionModel
    var denominatorPartModel:ExpressionModel
    
    init(id: Int, showCaret: Bool, parentModel: ArrowListener?) {
        self.id = id
        self.showCaret = showCaret
        self.parentModel = parentModel
        self.fontSize = parentModel?.fontSize ?? 20
        self.numeratorPartModel = ExpressionModel(id:1, parentModel:nil, fontSize:self.fontSize)
        self.denominatorPartModel = ExpressionModel(id:2, parentModel:nil, fontSize:self.fontSize)
        self.numeratorPartModel.parentModel = self
        self.denominatorPartModel.parentModel = self
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
        parentModel!.onLeftArrowFromChild(self);
    }
    
    func onRightArrowFromChild(_ childModel: any ArrowListener) {
        parentModel!.onRightArrowFromChild(self);
    }
    
    func onUpArrowFromChild(_ childModel: ArrowListener) {
        if(childModel as? ExpressionModel === numeratorPartModel){
            //already in top part, now let's parentModel to handle
            parentModel!.onUpArrowFromChild(self);
        }else if(childModel as? ExpressionModel === denominatorPartModel){
            numeratorPartModel.setFocus(FocusDirectionEnum.RIGHT);
        }
    }
    
    func onDownArrowFromChild(_ childModel: any ArrowListener) {
        if(childModel as? ExpressionModel === numeratorPartModel){
            denominatorPartModel.setFocus(FocusDirectionEnum.RIGHT);
        }else if(childModel as? ExpressionModel === denominatorPartModel){
            //already in bottom part, now let's parentModel to handle
            parentModel!.onDownArrowFromChild(self);
        }
    }
    
    func setFocus(_ direction: FocusDirectionEnum) {
        if(direction == FocusDirectionEnum.LEFT){
            numeratorPartModel.setFocus(FocusDirectionEnum.LEFT);
        }else{
            denominatorPartModel.setFocus(FocusDirectionEnum.RIGHT);
        }
    }
    
    func loseFocus() {
        numeratorPartModel.loseFocus();
        denominatorPartModel.loseFocus();
    }
    
    func handleDeleteFromChild(_ childModel: any ArrowListener) {
        
    }
}
