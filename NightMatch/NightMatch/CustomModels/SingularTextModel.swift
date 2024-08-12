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
    var fontSize: Int
    
    init(id:Int, text: String, showCaret: Bool, isEndChar:Bool, fontSize:Int) {
        self.id = id
        self.text = text
        self.showCaret = showCaret
        self.isEndChar = isEndChar
        if(isEndChar){
            self.id = 999
        }
        self.fontSize = fontSize
    }
}
