//
//  KeyboardPanel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/14.
//

import SwiftUI

struct KeyboardPanel: View {
    let directionListener: DirectionListener?
    let undoListener: UndoListener?
    let okExeListener: OkExeListener?
    let mathListener: MathListener?
    let deleteListener: DeleteListener?
    let acListener: ACListener?
    let historyListener: HistoryListener?
    let formatListener: FormatListener?
    let mainListener: MainListener?
    let varListener: VarListener?
    let funListener: FunListener?
    let shiftListener: ShiftListener?
    
    let btnSpacing:CGFloat = 2
    let rowWidthPct = 1.0

    init(shiftListener: ShiftListener?, varListener: VarListener?, funListener:FunListener?, mainListener: MainListener?, formatListener: FormatListener, directionListener: DirectionListener, undoListener: UndoListener, okExeListener: OkExeListener, mathListener: MathListener, deleteListener: DeleteListener, acListener: ACListener, historyListener: HistoryListener){
        self.shiftListener = shiftListener
        self.varListener = varListener
        self.funListener = funListener
        self.mainListener = mainListener
        self.formatListener = formatListener
        self.directionListener = directionListener
        self.undoListener = undoListener
        self.okExeListener = okExeListener
        self.mathListener = mathListener
        self.deleteListener = deleteListener
        self.acListener = acListener
        self.historyListener = historyListener
    }
    
    @State var showingFormat:Bool = false
    @StateObject var formatData:FormatData = FormatData()
    
    @State var showingHistory:Bool = false
    func rerunItemCallback(_ id:UUID) -> Void{
        let expression = HistoryUtil.loadItemExpressionDataJsonStr(id)
        historyListener?.rerun(expression)
    }
    
    @State var showingVar:Bool = false
    func selectVarItemCallback(_ varName:SingularTextEnum) -> Void{
        varListener?.addVar(varName)
    }
    
    @State var showingFun:Bool = false
    func selectFunItemCallback(_ funName:String) -> Void{
        funListener?.addFun(funName)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing:0){
                //row 1
                HStack(spacing:btnSpacing){
                    KeyboardButtonImageText(image: Image("custom_button_onoff"), secondText: "ON/OFF", fontSize:12,  imageScale:0.6, textColor: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255), action:{
                        //
                    })
                    KeyboardButtonImageText(image: Image("custom_button_main"), secondText: "MAIN", fontSize:16, imageScale:0.6, textColor: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255), action:{
                        if(self.mainListener != nil){
                            self.mainListener!.gotoMain()
                        }
                    })
                    KeyboardButtonImageText(image: Image("custom_button_history"), secondText: "PASTE", fontSize:16, imageScale:0.6, action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            //paste
                            if let text = UIPasteboard.general.string {
                                historyListener?.rerun(text)
                                // Use the clipboardText as needed
                            }
                        }else{
                            // Checking if the optionalBool has a value and it's true
                            if let unwrappedBool = historyListener?.showHistory(), unwrappedBool {
                                // The optionalBool has a value and it's true
                                showingHistory = true
                            } else {
                                // The optionalBool is either nil or false
                                showingHistory = false
                            }
                        }
                    }).sheet(isPresented: $showingHistory) {
                        HistoryList(rerunItemCallback:rerunItemCallback)
                    }
                    KeyboardButtonImageText(image: Image("custom_button_arrow_up"), secondText: " ", imageScale:0.6, action:{
                        directionListener?.onUpArrow()
                    })
                    KeyboardButtonImageText(image: Image("custom_button_undo"), secondText: "UNDO", fontSize:16, imageScale:0.6, textColor: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255), action:{
                        undoListener?.undo()
                    })
                    KeyboardButtonImageText(image: Image("custom_button_arrow_head"), secondText: " ", imageScale:0.6, action:{
                        directionListener?.onHeadArrow()
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                //row 2
                HStack(spacing:btnSpacing){
                    KeyboardButtonImageText(image: Image("custom_button_set"), secondText: "SET", imageScale:0.6, textColor: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255), action:{
                        //
                    })
                    KeyboardButtonImageText(image: Image("custom_button_return"), secondText: " ", imageScale:0.6, action:{
                        //
                    })
                    KeyboardButtonImageText(image: Image("custom_button_arrow_left"), secondText: " ", imageScale:0.6, action:{
                        directionListener?.onLeftArrow()
                    })
                    KeyboardButtonTextText(text: "OK", secondText: " ", action:{
                        okExeListener?.onOK()
                    },accessibilityIdentifier: KeyboardButtonIdentifiers.ok)
                    KeyboardButtonImageText(image: Image("custom_button_arrow_right"), secondText: " ", imageScale:0.5, action:{
                        directionListener?.onRightArrow()
                    })
                    KeyboardButtonImageText(image: Image("custom_button_arrow_tail"), secondText: " ", imageScale:0.6, action:{
                        directionListener?.onTailArrow()
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                //row 3
                HStack(spacing:btnSpacing){
                    KeyboardButtonImageText(image: Image("custom_button_shift"), secondText: "SHIFT", fontSize:16, bgColor: Color(red: 102 / 255, green: 204 / 255, blue: 255 / 255), textColor: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255),action:{
                        if(self.shiftListener == nil){
                            return
                        }
                        if(self.shiftListener!.isShiftPressed()){
                            self.shiftListener!.resetShift()
                        }else{
                            self.shiftListener!.pressShift()
                        }
                    })
                    KeyboardButtonImageText(image: Image("custom_button_var"), secondText: "VAR", imageScale:1.2, textColor: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255),action:{
                        // Checking if the optionalBool has a value and it's true
                        if let unwrappedBool = historyListener?.showHistory(), unwrappedBool {
                            // The optionalBool has a value and it's true
                            showingVar = true
                        } else {
                            // The optionalBool is either nil or false
                            showingVar = false
                        }
                    }).sheet(isPresented: $showingVar) {
                        VarList(selectItemCallback:selectVarItemCallback)
                    }
                    KeyboardButtonImageText(image: Image("custom_button_fx"), secondText: "FUN", imageScale:0.6, textColor: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255),action:{
                        showingFun = true
                    }).sheet(isPresented: $showingFun) {
                        FunList(selectItemCallback:selectFunItemCallback)
                    }
                    KeyboardButtonImageText(image: Image("custom_button_arrow_down"), secondText: " ", imageScale:0.6, action:{
                        directionListener?.onDownArrow()
                    })
                    KeyboardButtonImageText(image: Image("custom_button_cata"), secondText: "CATA", fontSize:16, imageScale:0.6, textColor: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255),action:{
                        //
                    })
                    KeyboardButtonImageText(image: Image("custom_button_tool"), secondText: "TOOL", fontSize:16, imageScale:0.6, textColor: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255),action:{
                        //
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                //row 4
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextImage(text: "𝑿", image:Image("custom_button_degree"), action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addSingularText(.CONST_E)
                        } else {
                            mathListener?.addSingularText(.VAR_X)
                        }
                    }, accessibilityIdentifier: KeyboardButtonIdentifiers.X)
                    KeyboardButtonImageImage(imageBottom:Image("custom_button_fraction"),imageUp:Image("custom_button_mixedfraction"),action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addMixedFraction()
                        } else {
                            mathListener?.addFraction()
                        }
                    }, accessibilityIdentifier: KeyboardButtonIdentifiers.fraction)
                    KeyboardButtonImageImage(imageBottom:Image("custom_button_sqrt"),imageUp:Image("custom_button_mixedsqrt"),action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addMixedSquareRoot()
                        } else {
                            mathListener?.addSquareRoot()
                        }
                    }, accessibilityIdentifier: KeyboardButtonIdentifiers.sqrt)
                    KeyboardButtonImageImage(imageBottom:Image("custom_button_xn"),imageUp:Image("custom_button_x1"),action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addSquare(1)
                        } else {
                            mathListener?.addSquare(0)
                        }
                    }, accessibilityIdentifier: KeyboardButtonIdentifiers.powern)
                    KeyboardButtonImageImage(imageBottom:Image("custom_button_x2"),imageUp:Image("custom_button_log"),action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addLogSimple("log")
                        } else {
                            mathListener?.addSquare(2)
                        }
                    }, accessibilityIdentifier: KeyboardButtonIdentifiers.powertwo)
                    KeyboardButtonImageImage(imageBottom:Image("custom_button_lognm"),imageUp:Image("custom_button_ln"),action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addLogSimple("ln")
                        } else {
                            mathListener?.addLogFull()
                        }
                    }, accessibilityIdentifier: KeyboardButtonIdentifiers.lognm)
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                //row 5
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextImage(text: "(一)", image:Image("custom_button_e"), action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addSingularText(.CONST_E)
                        } else {
                            mathListener?.addSingularText(.NEGATIVE)
                        }
                    }, accessibilityIdentifier: KeyboardButtonIdentifiers.one_bracket)

                    KeyboardButtonTextImage(text: "sin", image:Image("custom_button_sin1"), action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addMethodWithOneArgument("arcsin")
                        }else{
                            mathListener?.addMethodWithOneArgument("sin")
                        }
                    },accessibilityIdentifier: KeyboardButtonIdentifiers.sin)

                    KeyboardButtonTextImage(text: "cos", image:Image("custom_button_cos1"), action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addMethodWithOneArgument("arccos")
                        } else {
                            mathListener?.addMethodWithOneArgument("cos")
                        }
                    }, accessibilityIdentifier: KeyboardButtonIdentifiers.cos)
                    KeyboardButtonTextImage(text: "tan", image:Image("custom_button_tan1"), action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addMethodWithOneArgument("arctan")
                        } else {
                            mathListener?.addMethodWithOneArgument("tan")
                        }
                    }, accessibilityIdentifier: KeyboardButtonIdentifiers.tan)
                    KeyboardButtonTextImage(text: "(", image:Image("custom_button_equal"), action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            // equal sign — not yet in SingularTextEnum, no-op for now
                        } else {
                            mathListener?.addSingularText(.LEFT_PARENTHESIS)
                        }
                    }, accessibilityIdentifier: KeyboardButtonIdentifiers.left_bracket)
                    KeyboardButtonTextImage(text: ")", image:Image("custom_button_comma"), action:{
                        mathListener?.addSingularText(.RIGHT_PARENTHESIS)
                    }, accessibilityIdentifier: KeyboardButtonIdentifiers.right_bracket)
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                //row 6
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "7", secondText: "π", action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addSingularText(.PI)
                        } else {
                            mathListener?.addSingularText(.SEVEN)
                        }
                    },accessibilityIdentifier: KeyboardButtonIdentifiers.num_7)
                    KeyboardButtonTextText(text: "8", secondText: "∠", action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addSingularText(.ANGLE)
                        } else {
                            mathListener?.addSingularText(.EIGHT)
                        }
                    },accessibilityIdentifier: KeyboardButtonIdentifiers.num_8)
                    KeyboardButtonTextText(text: "9", secondText: "i", action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addSingularText(.COMPLEX_I)
                        } else {
                            mathListener?.addSingularText(.NINE)
                        }
                    },accessibilityIdentifier: KeyboardButtonIdentifiers.num_9)
                    KeyboardButtonImageText(image: Image("custom_button_delete"), secondText: " ", action:{
                        deleteListener?.onDelete()
                    })
                    KeyboardButtonTextText(text: "AC", secondText: " ", action:{
                        acListener?.onAC()
                    },accessibilityIdentifier: KeyboardButtonIdentifiers.ac)
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                //row 7
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "4", secondText: "A", action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addSingularText(.VAR_A)
                        } else {
                            mathListener?.addSingularText(.FOUR)
                        }
                    },accessibilityIdentifier: KeyboardButtonIdentifiers.num_4)
                    KeyboardButtonTextText(text: "5", secondText: "B", action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addSingularText(.VAR_B)
                        } else {
                            mathListener?.addSingularText(.FIVE)
                        }
                    },accessibilityIdentifier: KeyboardButtonIdentifiers.num_5)
                    KeyboardButtonTextText(text: "6", secondText: "C", action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addSingularText(.VAR_C)
                        } else {
                            mathListener?.addSingularText(.SIX)
                        }
                    },accessibilityIdentifier: KeyboardButtonIdentifiers.num_6)
                    KeyboardButtonTextImage(text: "×", image:Image("custom_button_int"), action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addIntegral()
                        } else {
                            mathListener?.addSingularText(.MULTIPLY)
                        }
                    }, accessibilityIdentifier: KeyboardButtonIdentifiers.multiply)
                    KeyboardButtonTextImage(text: "÷", image:Image("custom_button_dx"), action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addDDX()
                        } else {
                            mathListener?.addSingularText(.DIVIDE)
                        }
                    }, accessibilityIdentifier: KeyboardButtonIdentifiers.divide)
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                //row 8
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "1", secondText: "D", action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addSingularText(.VAR_D)
                        } else {
                            mathListener?.addSingularText(.ONE)
                        }
                    },accessibilityIdentifier: KeyboardButtonIdentifiers.num_1)
                    KeyboardButtonTextText(text: "2", secondText: "E", action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addSingularText(.VAR_E)
                        } else {
                            mathListener?.addSingularText(.TWO)
                        }
                    },accessibilityIdentifier: KeyboardButtonIdentifiers.num_2)
                    KeyboardButtonTextText(text: "3", secondText: "F", action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addSingularText(.VAR_F)
                        } else {
                            mathListener?.addSingularText(.THREE)
                        }
                    },accessibilityIdentifier: KeyboardButtonIdentifiers.num_3)
                    KeyboardButtonTextText(text: "+", secondText: "nPr", action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addMethodWithTwoArguments("nPr")
                        } else {
                            mathListener?.addSingularText(.ADD)
                        }
                    },accessibilityIdentifier: KeyboardButtonIdentifiers.add)
                    KeyboardButtonTextText(text: "-", secondText: "nCr", action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addMethodWithTwoArguments("nCr")
                        } else {
                            mathListener?.addSingularText(.SUBTRACT)
                        }
                    },accessibilityIdentifier: KeyboardButtonIdentifiers.subtract)
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                //row 9
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "0", secondText: "x", action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addSingularText(.VAR_X)
                        }else{
                            mathListener?.addSingularText(.ZERO)
                        }
                    },accessibilityIdentifier: KeyboardButtonIdentifiers.num_0)
                    KeyboardButtonTextText(text: ".", secondText: "y", action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addSingularText(.VAR_Y)
                        } else {
                            mathListener?.addSingularText(.DOT)
                        }
                    },accessibilityIdentifier: KeyboardButtonIdentifiers.num_dot)
                    KeyboardButtonImageText(image: Image("custom_button_x10n"), secondText: "z", action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            mathListener?.addSingularText(.VAR_Z)
                        } else {
                            mathListener?.addMultiplySquare()
                        }
                    }, accessibilityIdentifier: KeyboardButtonIdentifiers.num_power10)
                    KeyboardButtonImageText(image: Image("custom_button_fmt"), secondText: "Ans", action:{
                        if shiftListener != nil && shiftListener!.isShiftPressed() {
                            shiftListener?.resetShift()
                            // Ans — not yet in SingularTextEnum, no-op for now
                        } else {
                            if(formatListener == nil){
                                return
                            }
                            let formatData = formatListener!.getFormat()
                              if(formatData == nil){
                                return
                            }
                            if(formatData!.formatList.isEmpty) {
                                return
                            }
                            self.showingFormat = true
                            self.formatData.formatList = formatData!.formatList
                        }
                    }, accessibilityIdentifier: KeyboardButtonIdentifiers.format)
                    .sheet(isPresented: $showingFormat) {
                        FormatList(formatList:self.formatData.formatList)
                    }
                    KeyboardButtonTextText(text: "EXE", secondText: " ", action:{
                        okExeListener?.onOK()
                    },accessibilityIdentifier: KeyboardButtonIdentifiers.exe)
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
            }
            .padding(btnSpacing)
            .background(Color(red: 37 / 255, green: 37 / 255, blue: 37 / 255))
        }
    }
}

#Preview {
    let expressionContext = ExpressionContext()
    let expressionModel = ExpressionModel(expressionContext:expressionContext, id: 1, parentModel: nil, fontSize: 20)
    expressionContext.rootExpressionModel = expressionModel
    expressionContext.activeExpressionModelId = expressionModel.id
    
    let fragmentCalculateController: FragmentCalulateController = FragmentCalulateController()
    fragmentCalculateController.setExpressionContext(expressionContext)
    
    return KeyboardPanel(shiftListener: fragmentCalculateController, varListener: fragmentCalculateController, funListener: fragmentCalculateController, mainListener:fragmentCalculateController, formatListener: fragmentCalculateController, directionListener: fragmentCalculateController, undoListener: fragmentCalculateController, okExeListener: fragmentCalculateController, mathListener: fragmentCalculateController, deleteListener: fragmentCalculateController, acListener: fragmentCalculateController, historyListener: fragmentCalculateController)
}
