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
    var text:String = ""
    var isEndChar:Bool = false
    var fontSize: CGFloat
    
    init(id:Int, text: String, showCaret: Bool, isEndChar:Bool, fontSize:CGFloat) {
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
    
    func getData() -> any ExpressionItemData {
        return SingularTextData(id:self.id, text:self.text);
    }
    
    func replicate(_ expressionItemData: any ExpressionItemData) {
        if let singularTextData = expressionItemData as? SingularTextData {
            self.text=singularTextData.text
            self.id = singularTextData.id
        } else {
            fatalError("Not SingularTextData: \(expressionItemData)")
        }
    }
}
