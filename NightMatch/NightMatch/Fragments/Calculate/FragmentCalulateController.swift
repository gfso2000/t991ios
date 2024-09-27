//
//  FragmentCalulateController.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/27.
//

import Foundation

class FragmentCalulateController:UndoListener, HistoryListener, DirectionListener, OkExeListener, MathListener, DeleteListener, ACListener {
    var expressionContext:ExpressionContext? = nil
    var expressionModel:ExpressionModel? = nil
    
    func setExpressionContext(_ expressionContext: ExpressionContext) {
        self.expressionContext = expressionContext
    }
    //todo, use readonly model. after OK, set result model. also the format list should be stored in controller, not context
    func setModel(_ expressionModel:ExpressionModel){
        self.expressionModel = expressionModel
    }
    func showHistory()->Bool {
        return true
    }
    func rerun(_ expression:String) -> Void {
        expressionContext!.rerun(expression)
    }
    
    func onDelete() {
        //expressionContext!.getActiveExpressionModel().delete()
        //todo, just test see if stateobject can work in non-view class
        expressionModel!.delete()
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
        //evaluate in expression context, and save result
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
