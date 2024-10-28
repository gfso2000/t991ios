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
        super.init()
    }
    
//    func getText() -> String{
//        return self.text
//    }
    
    required init(_ jsonObject:[String: Any]){
        self.id = jsonObject["id"] as! Int
        self.text = jsonObject["text"] as! String
        super.init(jsonObject)
    }
    override func getDataAsJson() -> [String: Any] {
        var jsonObject: [String: Any] = [:]
        jsonObject["className"] = String(describing: Self.self)
        jsonObject["id"] = self.id
        jsonObject["text"] = self.text
        return jsonObject
    }
    
    override func getDataAsQalculate() -> String {
        return text
    }
    
    override func getDataAsLatex() -> String {
        if(text == "%"){
            return "\\%";
        }
        return text
    }
}
