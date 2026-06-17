//
//  SquareRootData.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/5.
//

import Foundation

class SquareRootData: ExpressionItemData {
    var id: Int
    var innerPartData: ExpressionData

    init(innerPartData: ExpressionData, id: Int) {
        self.innerPartData = innerPartData
        self.id = id
        super.init()
    }

    required init(_ jsonObject: [String: Any]) {
        self.innerPartData = ExpressionData(jsonObject["innerPartData"] as! [String: Any])
        self.id = jsonObject["id"] as! Int
        super.init(jsonObject)
    }

    override func getDataAsJson() -> [String: Any] {
        var jsonObject: [String: Any] = [:]
        jsonObject["className"] = String(describing: Self.self)
        jsonObject["id"] = self.id
        jsonObject["innerPartData"] = self.innerPartData.getDataAsJson()
        return jsonObject
    }

    override func getDataAsQalculate() -> String {
        return "sqrt(" + innerPartData.getDataAsQalculate() + ")"
    }

    override func getDataAsLatex() -> String {
        return "\\sqrt{" + innerPartData.getDataAsLatex() + "}"
    }

    override func getMaxFractionLevel() -> Int {
        return innerPartData.getMaxFractionLevel()
    }
}
