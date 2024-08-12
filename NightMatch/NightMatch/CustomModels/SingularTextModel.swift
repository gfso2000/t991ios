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
    init(id:Int, text: String, hasFocus: Bool) {
        self.id = id
        self.text = text
        self.showCaret = hasFocus
    }
}
