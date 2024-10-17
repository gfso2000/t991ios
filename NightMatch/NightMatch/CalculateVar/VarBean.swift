//
//  VarBean.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/10/16.
//

import Foundation

struct VarBean : Identifiable, Codable {
    var id: UUID
    var varName: String
    var expressionDataJsonStr: String = ""

    init(varName:String, expressionData: ExpressionData){
        self.id = UUID()
        self.varName = varName
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: expressionData.getDataAsJson(), options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: .utf8){
                self.expressionDataJsonStr = jsonString
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getExpressionData()->ExpressionData {
        if let jsonData = expressionDataJsonStr.data(using: .utf8) {
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                let decodedExpressionData = ExpressionData(jsonObject as! [String : Any]);
                return decodedExpressionData
            } catch {
                print("Error: \(error)")
            }
        }
        return ExpressionData.zeroExpressionData()
    }
//    init(_ jsonObject:[String: Any]){
//        self.varName = jsonObject["varName"] as! String
//        
//        if let childrenJsonObject:[String: Any] = jsonObject["expressionDataAsJson"] as? [String : Any] {
//            self.expressionData = ExpressionData(childrenJsonObject)
//        }
//    }
//    
//    func getDataAsJson() -> [String: Any] {
//        var jsonObject: [String: Any] = [:]
//        jsonObject["varName"] = self.varName
//        jsonObject["expressionDataAsJson"] = self.expressionData?.getDataAsJson()
//        return jsonObject
//    }
}
