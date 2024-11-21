//
//  FractionData.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/5.
//

import Foundation

class MethodOneData : ExpressionItemData{
    var id:Int
    var innerPartData: ExpressionData
    var type:String
    
    init(innerPartData: ExpressionData, id: Int, type: String) {
        self.innerPartData = innerPartData
        self.id = id
        self.type = type
        super.init()
    }
    
    required init(_ jsonObject: [String : Any]) {
        self.innerPartData = ExpressionData(jsonObject["innerPartData"] as! [String : Any]);
        self.id = jsonObject["id"] as! Int
        self.type = jsonObject["type"] as! String
        super.init(jsonObject)
    }
    
    override func getDataAsJson() -> [String: Any] {
        var jsonObject: [String: Any] = [:]
        jsonObject["className"] = String(describing: Self.self)
        jsonObject["id"] = self.id
        jsonObject["type"] = self.type
        jsonObject["innerPartData"] = self.innerPartData.getDataAsJson()
        return jsonObject
    }
    
    func getInnerPartData() -> ExpressionData {
        return self.innerPartData
    }
    
    override func getDataAsQalculate() -> String {
        if "f" == type {
            return "(" + FxGxUtil.FX + innerPartData.getDataAsQalculate() + "))"
        }
        if "g" == type {
            return "(" + FxGxUtil.GX + innerPartData.getDataAsQalculate() + "))"
        }
        return ""
    }
    
    override func getDataAsLatex() -> String {
        return type+"({"+innerPartData.getDataAsLatex()+"})"
    }
    
    override func getMaxFractionLevel() -> Int {
        return innerPartData.getMaxFractionLevel()
    }
}
