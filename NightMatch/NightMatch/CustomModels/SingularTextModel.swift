//
//  SingularTextModel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import Foundation

class SingularTextModel : Caretable,ObservableObject{
    @Published var showCaret: Bool = false
    var id:Int = 0
    var text:SingularTextEnum
    var isEndChar:Bool = false
    var fontSize: CGFloat
    
    init(id:Int, text: SingularTextEnum, showCaret: Bool, isEndChar:Bool, fontSize:CGFloat) {
        self.id = id
        self.text = text
        self.showCaret = showCaret
        self.isEndChar = isEndChar
        if(isEndChar){
            self.id = 999
        }
        self.fontSize = fontSize
    }
    
    func findExpressionModelById(_ expressionModelId: Int) -> ExpressionModel? {
        return nil
    }
    
    func getData() -> ExpressionItemData {
        return SingularTextData(id:self.id, text:self.text);
    }
    
    func replicate(_ expressionItemData: ExpressionItemData) {
        if let singularTextData = expressionItemData as? SingularTextData {
            self.text=singularTextData.text
            self.id = singularTextData.id
        } else {
            fatalError("Not SingularTextData: \(expressionItemData)")
        }
    }
    
    func isLeftParenthesis() -> Bool {
        return self.text == .LEFT_PARENTHESIS
    }
    func isRightParenthesis() -> Bool {
        return self.text == .RIGHT_PARENTHESIS
    }
    func isVariableABCEDEFxyz() -> Bool {
        return self.text == .VAR_A || self.text == .VAR_B || self.text == .VAR_C || self.text == .VAR_D
        || self.text == .VAR_E || self.text == .VAR_F
        || self.text == .VAR_X || self.text == .VAR_Y || self.text == .VAR_Z;
    }
    func isX() -> Bool {
        return self.text == .VAR_X
    }
    func isPI() -> Bool {
        return self.text == .PI
    }
    func isE() -> Bool {
        return self.text == .CONST_E
    }
    func isNumber() -> Bool {
        return self.text == .ZERO || self.text == .ONE || self.text == .TWO || self.text == .THREE
        || self.text == .FOUR || self.text == .FIVE || self.text == .SIX || self.text == .SEVEN
        || self.text == .EIGHT || self.text == .NINE
    }
    func isDot() -> Bool {
        return self.text == .DOT
    }
    func isMat() -> Bool {
        return false
    }
}
