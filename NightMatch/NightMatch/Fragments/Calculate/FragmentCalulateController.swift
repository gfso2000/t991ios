//
//  FragmentCalulateController.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/27.
//

import Foundation

class FragmentCalulateController:UndoListener, HistoryListener, DirectionListener, OkExeListener, MathListener, DeleteListener, ACListener {
    var expressionContext:ExpressionContext? = nil
    var resultModel:ExpressionModel? = nil
    
    func setExpressionContext(_ expressionContext: ExpressionContext) {
        //this expressionContext is used for editable expressionModel
        self.expressionContext = expressionContext
    }
    func setResultModel(_ resultModel:ExpressionModel){
        //result model is readonly, no need delete/focus/left/right/undo, so no need expressionContext
        self.resultModel = resultModel
    }
    
    func showHistory()->Bool {
        return true
    }
    func rerun(_ expression:String) -> Void {
        expressionContext!.rerun(expression)
    }
    
    func onDelete() {
        expressionContext!.getActiveExpressionModel().delete()
    }
    
    func onAC() {
        expressionContext!.onAC()
    }
    
    func addFraction() {
        expressionContext!.getActiveExpressionModel().addFraction()
    }
    
    func addSingularText(_ text:String) {
        expressionContext!.getActiveExpressionModel().addSingularText(text)
    }
    
    func onOK() {
        //evaluate in expression context, and save result
        resultModel!.onAC()
        resultModel!.replicate(expressionContext!.getMathExpression())
    }
    
    func onUpArrow() {
        expressionContext!.getActiveExpressionModel().onUpArrow()
    }
    
    func onDownArrow() {
        expressionContext!.getActiveExpressionModel().onDownArrow()
    }
    
    func onLeftArrow() {
        expressionContext!.getActiveExpressionModel().onLeftArrow()
    }
    
    func onRightArrow() {
        expressionContext!.getActiveExpressionModel().onRightArrow()
    }
    
    func undo() {
        expressionContext!.onUndo()
    }
}
