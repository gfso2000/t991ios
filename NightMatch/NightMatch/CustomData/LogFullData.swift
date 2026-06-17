//
//  LogFullData.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/5.
//

import Foundation

class LogFullData: ExpressionItemData {
    var id: Int
    var bottomPartData: ExpressionData
    var topPartData: ExpressionData

    init(bottomPartData: ExpressionData, topPartData: ExpressionData, id: Int) {
        self.bottomPartData = bottomPartData
        self.topPartData = topPartData
        self.id = id
        super.init()
    }

    required init(_ jsonObject: [String: Any]) {
        self.bottomPartData = ExpressionData(jsonObject["bottomPartData"] as! [String: Any])
        self.topPartData = ExpressionData(jsonObject["topPartData"] as! [String: Any])
        self.id = jsonObject["id"] as! Int
        super.init(jsonObject)
    }

    override func getDataAsJson() -> [String: Any] {
        var jsonObject: [String: Any] = [:]
        jsonObject["className"] = String(describing: Self.self)
        jsonObject["id"] = self.id
        jsonObject["bottomPartData"] = self.bottomPartData.getDataAsJson()
        jsonObject["topPartData"] = self.topPartData.getDataAsJson()
        return jsonObject
    }

    override func getDataAsQalculate() -> String {
        return "log(" + topPartData.getDataAsQalculate() + "," + bottomPartData.getDataAsQalculate() + ")"
    }

    override func getDataAsLatex() -> String {
        return "log_{" + bottomPartData.getDataAsLatex() + "}({" + topPartData.getDataAsLatex() + "})"
    }

    override func getMaxFractionLevel() -> Int {
        return max(topPartData.getMaxFractionLevel(), bottomPartData.getMaxFractionLevel())
    }
}
