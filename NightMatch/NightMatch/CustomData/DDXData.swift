//
//  DDXData.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/5.
//

import Foundation

class DDXData: ExpressionItemData {
    var id: Int
    var mainPartData: ExpressionData
    var constantPartData: ExpressionData

    init(mainPartData: ExpressionData, constantPartData: ExpressionData, id: Int) {
        self.mainPartData = mainPartData
        self.constantPartData = constantPartData
        self.id = id
        super.init()
    }

    required init(_ jsonObject: [String: Any]) {
        self.mainPartData = ExpressionData(jsonObject["mainPartData"] as! [String: Any])
        self.constantPartData = ExpressionData(jsonObject["constantPartData"] as! [String: Any])
        self.id = jsonObject["id"] as! Int
        super.init(jsonObject)
    }

    override func getDataAsJson() -> [String: Any] {
        var jsonObject: [String: Any] = [:]
        jsonObject["className"] = String(describing: Self.self)
        jsonObject["id"] = self.id
        jsonObject["mainPartData"] = self.mainPartData.getDataAsJson()
        jsonObject["constantPartData"] = self.constantPartData.getDataAsJson()
        return jsonObject
    }

    override func getDataAsQalculate() -> String {
        var mainPart = mainPartData.getDataAsQalculate()
        mainPart = mainPart.replacingOccurrences(of: "#varX#", with: "x")
        return "diff(" + mainPart + ", x, 1, " + constantPartData.getDataAsQalculate() + ")"
    }

    override func getDataAsLatex() -> String {
        return "\\frac{d}{dx}({" + mainPartData.getDataAsLatex() + "})_{|x={" + constantPartData.getDataAsLatex() + "}}"
    }

    override func getMaxFractionLevel() -> Int {
        return mainPartData.getMaxFractionLevel()
    }
}
