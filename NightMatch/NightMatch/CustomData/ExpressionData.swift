//
//  ExpressionData.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/5.
//

import Foundation

class ExpressionData {
    var lastFocusedChildrenId:Int
    var children:[ExpressionItemData]
    var id:Int
    
    init(lastFocusedChildrenId: Int, children: [ExpressionItemData], id: Int) {
        self.lastFocusedChildrenId = lastFocusedChildrenId
        self.children = children
        self.id = id
    }
    
    init(_ jsonObject:[String: Any]){
        self.id = jsonObject["id"] as! Int
        self.lastFocusedChildrenId = jsonObject["lastFocusedChildrenId"] as! Int
        self.children = []
        let childrenJsonObject:[[String: Any]] = jsonObject["children"] as! [[String : Any]]
        for childJsonObject in childrenJsonObject {
            let className:String = childJsonObject["className"] as! String
            let cfBundleName:String = Bundle.main.infoDictionary?["CFBundleName"] as! String
            if let classType = NSClassFromString(cfBundleName+"."+className) as? ExpressionItemData.Type {
                let instance = classType.init(childJsonObject)
                self.children.append(instance)
            }
        }
    }
    func getDataAsJson() -> [String: Any] {
        var jsonObject: [String: Any] = [:]
        jsonObject["className"] = String(describing: Self.self)
        jsonObject["id"] = self.id
        jsonObject["lastFocusedChildrenId"] = self.lastFocusedChildrenId
        
        var childrenJsonObject:[[String: Any]] = []
        for child in children {
            childrenJsonObject.append(child.getDataAsJson())
        }
        jsonObject["children"] = childrenJsonObject
        return jsonObject
    }
    func getDataAsQalculate() -> String{
        var str:String = ""
        for expressionItemData in children {
            str.append(expressionItemData.getDataAsQalculate())
        }
        return str
    }
    
    static func zeroExpressionData()->ExpressionData {
        let expressionItemData:SingularTextData = SingularTextData(id: 1, text: "000000000000000000000000000000")
        let children:[ExpressionItemData] = [expressionItemData]
        let expressionData: ExpressionData = ExpressionData(lastFocusedChildrenId: 1, children: children, id: 2)
        return expressionData
    }
    
    static func oneExpressionData()->ExpressionData {
        let expressionItemData:SingularTextData = SingularTextData(id: 1, text: "123")
        let children:[ExpressionItemData] = [expressionItemData]
        let expressionData: ExpressionData = ExpressionData(lastFocusedChildrenId: 1, children: children, id: 2)
        return expressionData
    }
}
