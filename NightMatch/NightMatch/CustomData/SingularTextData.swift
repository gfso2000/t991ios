//
//  SingularTextData.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/5.
//

import Foundation

class SingularTextData:ExpressionItemData{
    var id:Int
    var text:String
    init(id: Int, text: String) {
        self.id = id
        self.text = text
    }
    
    func getText() -> String{
        return self.text
    }
}
