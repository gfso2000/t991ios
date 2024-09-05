//
//  ExpressionContext.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/5.
//

import Foundation

class ExpressionContext{
    var rootExpressionModel:ExpressionModel?
    var activeExpressionModelId:Int = 0
    var handleUndoExpressionModelId:Int = 0
    
    func getActiveExpressionModel() -> ExpressionModel{
        let activeExpressionModel = rootExpressionModel!.findExpressionModelById(activeExpressionModelId);
        if (activeExpressionModel != nil) {
            return activeExpressionModel!;
        }
        return rootExpressionModel!;
    }
    
    func getHandleUndoExpressionModel() -> ExpressionModel?{
        if (handleUndoExpressionModelId == 0) {
            return nil;
        }
        let handleUndoExpressionModel = rootExpressionModel!.findExpressionModelById(handleUndoExpressionModelId);
        return handleUndoExpressionModel;
    }
    
    func onAC() -> Void{
        rootExpressionModel!.onAC();
    }
    
    func onUndo() -> Void{
        let undoExpressionModel = getHandleUndoExpressionModel();
        if (undoExpressionModel != nil && undoExpressionModel!.canUndo()) {
            getActiveExpressionModel().loseFocus();
            undoExpressionModel!.undo();
        }
    }
}
