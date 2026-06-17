//
//  MixedSquareRootData.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/5.
//

import Foundation

class MixedSquareRootData: ExpressionItemData {
    var id: Int
    var outerPartData: ExpressionData
    var innerPartData: ExpressionData

    init(outerPartData: ExpressionData, innerPartData: ExpressionData, id: Int) {
        self.outerPartData = outerPartData
        self.innerPartData = innerPartData
        self.id = id
        super.init()
    }

    required init(_ jsonObject: [String: Any]) {
        self.outerPartData = ExpressionData(jsonObject["outerPartData"] as! [String: Any])
        self.innerPartData = ExpressionData(jsonObject["innerPartData"] as! [String: Any])
        self.id = jsonObject["id"] as! Int
        super.init(jsonObject)
    }

    override func getDataAsJson() -> [String: Any] {
        var jsonObject: [String: Any] = [:]
        jsonObject["className"] = String(describing: Self.self)
        jsonObject["id"] = self.id
        jsonObject["outerPartData"] = self.outerPartData.getDataAsJson()
        jsonObject["innerPartData"] = self.innerPartData.getDataAsJson()
        return jsonObject
    }

    override func getDataAsQalculate() -> String {
        return "root(" + innerPartData.getDataAsQalculate() + ", " + outerPartData.getDataAsQalculate() + ")"
    }

    override func getDataAsLatex() -> String {
        return "\\sqrt[{" + outerPartData.getDataAsLatex() + "}]{" + innerPartData.getDataAsLatex() + "}"
    }

    override func getMaxFractionLevel() -> Int {
        return max(outerPartData.getMaxFractionLevel(), innerPartData.getMaxFractionLevel())
    }
}
