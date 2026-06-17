//
//  SumData.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/5.
//

import Foundation

class SumData: ExpressionItemData {
    var id: Int
    var mainPartData: ExpressionData
    var topPartData: ExpressionData
    var bottomPartData: ExpressionData

    init(mainPartData: ExpressionData, topPartData: ExpressionData, bottomPartData: ExpressionData, id: Int) {
        self.mainPartData = mainPartData
        self.topPartData = topPartData
        self.bottomPartData = bottomPartData
        self.id = id
        super.init()
    }

    required init(_ jsonObject: [String: Any]) {
        self.mainPartData = ExpressionData(jsonObject["mainPartData"] as! [String: Any])
        self.topPartData = ExpressionData(jsonObject["topPartData"] as! [String: Any])
        self.bottomPartData = ExpressionData(jsonObject["bottomPartData"] as! [String: Any])
        self.id = jsonObject["id"] as! Int
        super.init(jsonObject)
    }

    override func getDataAsJson() -> [String: Any] {
        var jsonObject: [String: Any] = [:]
        jsonObject["className"] = String(describing: Self.self)
        jsonObject["id"] = self.id
        jsonObject["mainPartData"] = self.mainPartData.getDataAsJson()
        jsonObject["topPartData"] = self.topPartData.getDataAsJson()
        jsonObject["bottomPartData"] = self.bottomPartData.getDataAsJson()
        return jsonObject
    }

    override func getDataAsQalculate() -> String {
        var mainPart = mainPartData.getDataAsQalculate()
        mainPart = mainPart.replacingOccurrences(of: "#varX#", with: "x")
        return "sum(" + mainPart + "; " + bottomPartData.getDataAsQalculate() + "; " + topPartData.getDataAsQalculate() + ")"
    }

    override func getDataAsLatex() -> String {
        return "\\sum_{" + bottomPartData.getDataAsLatex() + "}^{" + topPartData.getDataAsLatex() + "}{" + mainPartData.getDataAsLatex() + "}"
    }

    override func getMaxFractionLevel() -> Int {
        return max(max(mainPartData.getMaxFractionLevel(), topPartData.getMaxFractionLevel()), bottomPartData.getMaxFractionLevel())
    }
}
