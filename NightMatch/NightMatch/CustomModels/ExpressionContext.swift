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
    
    func getMathExpression() -> String{
        let expressionData = rootExpressionModel!.getData()
        addToHistory(expressionData)
        return expressionData.getDataAsQalculate()
    }
    
    func addToHistory(_ expressionData:ExpressionData) -> Void{
        if(expressionData.children.isEmpty){
            return
        }
        var historyBeanList:[CalculateHistoryBean] = HistoryUtil.loadHistory()
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: expressionData.getDataAsJson(), options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: .utf8){
                print(jsonString)
                historyBeanList.insert(CalculateHistoryBean(id:UUID(), expressionDataJsonStr:jsonString, expressionDataLatexStr: expressionData.getDataAsQalculate(), fractionResult: "4", decimalResult: "4.0000"), at:0)
                HistoryUtil.saveHistory(historyBeanList)
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func rerun(_ expression:String) -> Void{
        onAC()
        if let jsonData = expression.data(using: .utf8) {
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                var decodedExpressionData = ExpressionData(jsonObject as! [String : Any]);
                rootExpressionModel!.loseFocus();
                rootExpressionModel!.replicate(decodedExpressionData)
                activeExpressionModelId = rootExpressionModel!.id
                getActiveExpressionModel().setFocus(FocusDirectionEnum.RIGHT);
            } catch {
                print("Error: \(error)")
            }
        }
    }
}
