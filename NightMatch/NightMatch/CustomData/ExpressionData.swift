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
        var childrenJsonObject:[[String: Any]] = jsonObject["children"] as! [[String : Any]]
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
}
