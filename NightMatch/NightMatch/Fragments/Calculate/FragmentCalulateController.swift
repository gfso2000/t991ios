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
    
    static let precision = 10

    func onOK() {
        let expressionData = expressionContext!.getMathExpression()
        expressionContext!.addToHistory(expressionData)

        let qalculateExpression = expressionData.getDataAsQalculate()

        // Evaluate with libqalculate across all mode combinations,
        // mirroring the Java MathInputControl approach.
        //
        // approximation indices (QalculateWrapper.h):
        //   0=EXACT  1=TRY_EXACT  2=APPROXIMATE  3=EXACT_VARIABLES
        // fraction format indices:
        //   0=DECIMAL  1=DECIMAL_EXACT  2=FRACTIONAL  3=COMBINED
        let approxModes:  [(Int, String)] = [
            (0, "APPROXIMATION_EXACT"),
            (1, "APPROXIMATION_TRY_EXACT"),
            (2, "APPROXIMATION_APPROXIMATE"),
            (3, "APPROXIMATION_EXACT_VARIABLES")
        ]
        let fractionFmts: [(Int, String)] = [
            (3, "FRACTION_COMBINED"),
            (2, "FRACTION_FRACTIONAL"),
            (0, "FRACTION_DECIMAL"),
            (1, "FRACTION_DECIMAL_EXACT")
        ]

        QalculateBridge.initialize_qalc()
        QalculateBridge.setPrecision(Int32(FragmentCalulateController.precision))

        formatData = FormatData()
        formatData!.defaultExpressionData = expressionData

        var beanId = 1
        var debugLog = ""
        for (approxIdx, approxName) in approxModes {
            for (fmtIdx, fmtName) in fractionFmts {
                let result = QalculateBridge.evaluate(
                    qalculateExpression,
                    approximation: Int32(approxIdx),
                    fractionFormat: Int32(fmtIdx),
                    timeoutMs: 60000
                )
                let label = "\(approxName):\(fmtName)"
                debugLog += "\(label):\(result)\n"
                
                formatData!.formatList.append(
                    FormatBean(id: beanId, name: label,
                               expressionData: MathResultToExpression.convertToExpressionData(result),
                               resultString: result)
                )
                formatData!.defaultExpressionData = MathResultToExpression.convertToExpressionData(result)
                beanId += 1
            }
            debugLog += "\n"
        }
        print(debugLog)

        resultModel!.onAC()
        if let defaultData = formatData?.defaultExpressionData {
            resultModel!.replicate(defaultData)
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
