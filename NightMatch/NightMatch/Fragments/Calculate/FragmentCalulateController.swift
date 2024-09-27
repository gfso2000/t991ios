//
//  FragmentCalulateController.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/27.
//

import Foundation

class FragmentCalulateController:UndoListener, HistoryListener, DirectionListener, OkExeListener, MathListener, DeleteListener, ACListener {
    var expressionContext:ExpressionContext? = nil
    
    func setExpressionContext(_ expressionContext: ExpressionContext) {
        self.expressionContext = expressionContext
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
        expressionContext!.getActiveExpressionModel().onAC()
    }
    
    
    func addFraction() {
        expressionContext!.getActiveExpressionModel().addFraction()
    }
    
    func addSingularText(_ text:String) {
        expressionContext!.getActiveExpressionModel().addSingularText(text)
    }
    
    func onOK() {
        print(expressionContext!.getMathExpression());
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
