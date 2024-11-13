//
//  SingularTextData.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/5.
//

import Foundation

class SingularTextData:ExpressionItemData{
    var id:Int
    var text:SingularTextEnum
    init(id: Int, text: SingularTextEnum) {
        self.id = id
        self.text = text
        super.init()
    }
    
//    func getText() -> String{
//        return self.text
//    }
    
    required init(_ jsonObject:[String: Any]){
        self.id = jsonObject["id"] as! Int
        self.text = SingularTextEnum.getEnumCase(by: jsonObject["text"] as! String) ?? .ZERO
        super.init(jsonObject)
    }
    override func getDataAsJson() -> [String: Any] {
        var jsonObject: [String: Any] = [:]
        jsonObject["className"] = String(describing: Self.self)
        jsonObject["id"] = self.id
        jsonObject["text"] = String(describing: self.text)
        return jsonObject
    }
    
    override func getDataAsQalculate() -> String {
        return text.rawValue
    }
    
    override func getDataAsLatex() -> String {
        if(text.rawValue == "%"){
            return "\\%";
        }
        return text.rawValue
    }
}
