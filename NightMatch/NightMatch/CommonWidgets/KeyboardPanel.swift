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
    
    let btnSpacing:CGFloat = 2
    let rowWidthPct = 1.0

    init(mainListener: MainListener?, formatListener: FormatListener, directionListener: DirectionListener, undoListener: UndoListener, okExeListener: OkExeListener, mathListener: MathListener, deleteListener: DeleteListener, acListener: ACListener, historyListener: HistoryListener){
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
        let expression = HistoryUtil.loadItemExpressionDataStr(id)
        historyListener?.rerun(expression)
    }
    
    @State var showingVar:Bool = false
    func selectItemCallback(_ varName:String) -> Void{
        
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing:0){
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
                        // Checking if the optionalBool has a value and it's true
                        if let unwrappedBool = historyListener?.showHistory(), unwrappedBool {
                            // The optionalBool has a value and it's true
                            showingHistory = true
                        } else {
                            // The optionalBool is either nil or false
                            showingHistory = false
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
                        //
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
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
                    })
                    KeyboardButtonImageText(image: Image("custom_button_arrow_right"), secondText: " ", imageScale:0.5, action:{
                        directionListener?.onRightArrow()
                    })
                    KeyboardButtonImageText(image: Image("custom_button_arrow_tail"), secondText: " ", imageScale:0.6, action:{
                        directionListener?.onRightArrow()
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonImageText(image: Image("custom_button_shift"), secondText: "SHIFT", fontSize:16, bgColor: Color(red: 102 / 255, green: 204 / 255, blue: 255 / 255), textColor: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255),action:{
                        //
                    })
                    KeyboardButtonImageText(image: Image("custom_button_var"), secondText: "VAR", imageScale:1.2, textColor: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255),action:{
                        showingVar = true
                    }).sheet(isPresented: $showingVar) {
                        VarList(selectItemCallback:selectItemCallback)
                    }
                    KeyboardButtonImageText(image: Image("custom_button_fx"), secondText: "FUN", imageScale:0.6, textColor: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255),action:{
                        //
                    })
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
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextImage(text: "𝑿", image:Image("custom_button_degree"), action:{
                        //
                    })
                    KeyboardButtonImageImage(imageBottom:Image("custom_button_fraction"),imageUp:Image("custom_button_mixedfraction"),action:{
                        mathListener?.addFraction()
                    })
                    KeyboardButtonImageImage(imageBottom:Image("custom_button_sqrt"),imageUp:Image("custom_button_mixedsqrt"),action:{
                        print("a")
                    })
                    KeyboardButtonImageImage(imageBottom:Image("custom_button_xn"),imageUp:Image("custom_button_x1"),action:{
                        print("a")
                    })
                    KeyboardButtonImageImage(imageBottom:Image("custom_button_x2"),imageUp:Image("custom_button_log"),action:{
                        print("a")
                    })
                    KeyboardButtonImageImage(imageBottom:Image("custom_button_lognm"),imageUp:Image("custom_button_ln"),action:{
                        print("a")
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextImage(text: "(一)", image:Image("custom_button_e"), action:{
                        //
                    })
                    KeyboardButtonTextImage(text: "sin", image:Image("custom_button_sin1"), action:{
                        //
                    })
                    KeyboardButtonTextImage(text: "cos", image:Image("custom_button_cos1"), action:{
                        //
                    })
                    KeyboardButtonTextImage(text: "tan", image:Image("custom_button_tan1"), action:{
                        //
                    })
                    KeyboardButtonTextImage(text: "(", image:Image("custom_button_equal"), action:{
                        //
                    })
                    KeyboardButtonTextImage(text: ")", image:Image("custom_button_comma"), action:{
                        //
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "7", secondText: "π", action:{
                        mathListener?.addSingularText("7")
                    })
                    KeyboardButtonTextText(text: "8", secondText: "∠", action:{
                        mathListener?.addSingularText("8")
                    })
                    KeyboardButtonTextText(text: "9", secondText: "i", action:{
                        mathListener?.addSingularText("9")
                    })
                    KeyboardButtonImageText(image: Image("custom_button_delete"), secondText: " ", action:{
                        deleteListener?.onDelete()
                    })
                    KeyboardButtonTextText(text: "AC", secondText: " ", action:{
                        acListener?.onAC()
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "4", secondText: "A", action:{
                        mathListener?.addSingularText("4")
                    })
                    KeyboardButtonTextText(text: "5", secondText: "B", action:{
                        mathListener?.addSingularText("5")
                    })
                    KeyboardButtonTextText(text: "6", secondText: "C", action:{
                        mathListener?.addSingularText("6")
                    })
                    KeyboardButtonTextImage(text: "×", image:Image("custom_button_int"), action:{
                        //
                    })
                    KeyboardButtonTextImage(text: "÷", image:Image("custom_button_dx"), action:{
                        //
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "1", secondText: "D", action:{
                        mathListener?.addSingularText("1")
                    })
                    KeyboardButtonTextText(text: "2", secondText: "E", action:{
                        mathListener?.addSingularText("2")
                    })
                    KeyboardButtonTextText(text: "3", secondText: "F", action:{
                        mathListener?.addSingularText("3")
                    })
                    KeyboardButtonTextText(text: "+", secondText: "nPr", action:{
                        //
                    })
                    KeyboardButtonTextText(text: "-", secondText: "nCr", action:{
                        //
                    })
                }
                .frame(width:geometry.size.width*rowWidthPct, height:geometry.size.height * 1/9)
                
                HStack(spacing:btnSpacing){
                    KeyboardButtonTextText(text: "0", secondText: "x", action:{
                        mathListener?.addSingularText("0")
                    })
                    KeyboardButtonTextText(text: ".", secondText: "y", action:{
                        //
                    })
                    KeyboardButtonImageText(image: Image("custom_button_x10n"), secondText: "z", action:{
                        //
                    })
                    KeyboardButtonTextText(text: ".", secondText: "Ans", action:{
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
                    })
                    .sheet(isPresented: $showingFormat) {
                        FormatList(formatList:self.formatData.formatList)
                    }
                    KeyboardButtonTextText(text: "EXE", secondText: " ", action:{
                        //
                    })
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
    
    return KeyboardPanel(mainListener:fragmentCalculateController, formatListener: fragmentCalculateController, directionListener: fragmentCalculateController, undoListener: fragmentCalculateController, okExeListener: fragmentCalculateController, mathListener: fragmentCalculateController, deleteListener: fragmentCalculateController, acListener: fragmentCalculateController, historyListener: fragmentCalculateController)
}
