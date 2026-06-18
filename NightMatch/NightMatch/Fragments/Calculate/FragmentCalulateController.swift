//
//  FragmentCalulateController.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/27.
//

import Foundation

class FragmentCalulateController:ShiftListener, VarListener, FunListener, UndoListener, HistoryListener, DirectionListener, OkExeListener, MathListener, DeleteListener, ACListener, FormatListener, MainListener {
    var expressionContext:ExpressionContext? = nil
    var resultModel:ExpressionModel? = nil
    var formatData:FormatData? = nil
    var activeFragment:ActiveFragment? = nil
    var indicatorState:IndicatorState? = nil
    
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
    
    func addFun(_ funName: String) {
        expressionContext!.getActiveExpressionModel().addMethodWithOneArgument(funName)
    }

    func showHistory()->Bool {
        return true
    }
    func rerun(_ expression:String) -> Void {
        expressionContext!.rerun(expression)
    }
    
    func setIndicatorState(_ indicatorState:IndicatorState) {
        self.indicatorState = indicatorState
    }
    func pressShift() {
        self.indicatorState?.shiftPressed = true
    }
    
    func resetShift() {
        self.indicatorState?.shiftPressed = false
    }
    
    func isShiftPressed() -> Bool {
        if(self.indicatorState != nil){
            return self.indicatorState!.shiftPressed
        }
        return false
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

    func addMixedFraction() {
        expressionContext!.getActiveExpressionModel().addMixedFraction()
    }

    func addSquareRoot() {
        expressionContext!.getActiveExpressionModel().addSquareRoot()
    }

    func addMixedSquareRoot() {
        expressionContext!.getActiveExpressionModel().addMixedSquareRoot()
    }

    func addSquare(_ type: Int) {
        expressionContext!.getActiveExpressionModel().addSquare(type)
    }

    func addMultiplySquare() {
        expressionContext!.getActiveExpressionModel().addMultiplySquare()
    }

    func addLogFull() {
        expressionContext!.getActiveExpressionModel().addLogFull()
    }

    func addLogSimple(_ type: String) {
        expressionContext!.getActiveExpressionModel().addLogSimple(type)
    }

    func addSingularText(_ text:SingularTextEnum) {
        expressionContext!.getActiveExpressionModel().addSingularText(text)
    }

    func addMethodWithOneArgument(_ type:String) {
        expressionContext!.getActiveExpressionModel().addMethodWithOneArgument(type)
    }

    func addMethodWithTwoArguments(_ type: String) {
        expressionContext!.getActiveExpressionModel().addMethodWithTwoArguments(type)
    }

    func addDDX() {
        expressionContext!.getActiveExpressionModel().addDDX()
    }

    func addIntegral() {
        expressionContext!.getActiveExpressionModel().addIntegral()
    }

    func addSum() {
        expressionContext!.getActiveExpressionModel().addSum()
    }

    func addAbs() {
        expressionContext!.getActiveExpressionModel().addAbs()
    }
    
    static let precision = 13

    func onOK() {
        let expressionData = expressionContext!.getMathExpression()
        let qalculateExpression = expressionData.getDataAsQalculate()
        if qalculateExpression == "" { return }
        expressionContext!.addToHistory(expressionData)

        let result = LibQalculateUtil.callQalculate(
            qalculateExpression,
            precision: FragmentCalulateController.precision
        )

        let decimalExpressionData     = MathResultToExpression.convertToExpressionData(result.decimalResult)
        let fractionExpressionData    = MathResultToExpression.convertToExpressionData(result.fractionResult)
        let combinedExpressionData    = MathResultToExpression.convertToExpressionData(result.combinedFractionResult)

        formatData = FormatData()
        formatData!.defaultExpressionData = decimalExpressionData
        formatData!.formatList.append(FormatBean(id: 1, name: "Decimal",
                                                 expressionData: decimalExpressionData,
                                                 resultString: result.decimalResult))
        formatData!.formatList.append(FormatBean(id: 2, name: "Fraction",
                                                 expressionData: fractionExpressionData,
                                                 resultString: result.fractionResult))
        formatData!.formatList.append(FormatBean(id: 3, name: "Mixed Number",
                                                 expressionData: combinedExpressionData,
                                                 resultString: result.combinedFractionResult))

        resultModel!.onAC()
        if let defaultData = formatData?.defaultExpressionData {
            resultModel!.replicate(defaultData)
            VarUtil.persistLastAns(defaultData)
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
