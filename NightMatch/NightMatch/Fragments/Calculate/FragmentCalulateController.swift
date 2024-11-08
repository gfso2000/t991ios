//
//  FragmentCalulateController.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/27.
//

import Foundation

class FragmentCalulateController:VarListener, UndoListener, HistoryListener, DirectionListener, OkExeListener, MathListener, DeleteListener, ACListener, FormatListener, MainListener {
    var expressionContext:ExpressionContext? = nil
    var resultModel:ExpressionModel? = nil
    var formatData:FormatData? = nil
    var activeFragment:ActiveFragment? = nil
    
    func setExpressionContext(_ expressionContext: ExpressionContext) {
        //this expressionContext is used for editable expressionModel
        self.expressionContext = expressionContext
    }
    func setResultModel(_ resultModel:ExpressionModel){
        //result model is readonly, no need delete/focus/left/right/undo, so no need expressionContext
        self.resultModel = resultModel
    }
    func setActiveFragmentObject(_ activeFragment: ActiveFragment){
        //environmentObject, used to switch main/calculate view
        self.activeFragment = activeFragment
    }
    
    ////////////////////////////////
    func showVar() -> Bool {
        return true
    }
    
    func addVar(_ varName: SingularTextEnum) {
        expressionContext!.getActiveExpressionModel().addSingularText(varName)
    }
    
    func showHistory()->Bool {
        return true
    }
    func rerun(_ expression:String) -> Void {
        expressionContext!.rerun(expression)
    }
    
    func gotoMain() {
        if(self.activeFragment != nil){
            self.activeFragment?.currentFragmentName = "Main"
        }
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
    
    func addSingularText(_ text:SingularTextEnum) {
        expressionContext!.getActiveExpressionModel().addSingularText(text)
    }
    
    func onOK() {
        let expressionData = expressionContext!.getMathExpression()
        //save to history
        expressionContext!.addToHistory(expressionData)

        //evaluate in expression context, and save result
        let resultExpressionData = expressionData
        //record default format
        formatData = FormatData()
        formatData!.defaultExpressionData = resultExpressionData
        //record other formats
        let decimalFormatBean = FormatBean(id: 1, name: "Decimal", expressionData: resultExpressionData)
        formatData?.formatList.append(decimalFormatBean)
        let fractionFormatBean = FormatBean(id: 2, name: "Fraction", expressionData: resultExpressionData)
        formatData?.formatList.append(fractionFormatBean)
        let fractionFormatBean2 = FormatBean(id: 3, name: "Fraction", expressionData: resultExpressionData)
        formatData?.formatList.append(fractionFormatBean2)
        let fractionFormatBean3 = FormatBean(id: 4, name: "Fraction", expressionData: resultExpressionData)
        formatData?.formatList.append(fractionFormatBean3)
        let fractionFormatBean4 = FormatBean(id: 5, name: "Fraction", expressionData: resultExpressionData)
        formatData?.formatList.append(fractionFormatBean4)
        let fractionFormatBean5 = FormatBean(id: 6, name: "Fraction", expressionData: resultExpressionData)
        formatData?.formatList.append(fractionFormatBean5)
        let fractionFormatBean6 = FormatBean(id: 7, name: "Fraction", expressionData: resultExpressionData)
        formatData?.formatList.append(fractionFormatBean6)
        let fractionFormatBean7 = FormatBean(id: 8, name: "Fraction", expressionData: resultExpressionData)
        formatData?.formatList.append(fractionFormatBean7)

        resultModel!.onAC()
        if(formatData?.defaultExpressionData != nil){
            resultModel!.replicate(formatData!.defaultExpressionData!)
        }
    }
    
    func getFormat() -> FormatData? {
        return formatData
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
    
    func onHeadArrow() {
        expressionContext!.onMoveHead()
    }
    
    func onTailArrow() {
        expressionContext!.onMoveTail()
    }
    
    func undo() {
        expressionContext!.onUndo()
    }
}
