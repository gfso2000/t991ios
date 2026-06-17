//
//  MixedFractionData.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/5.
//

import Foundation

class MixedFractionData: ExpressionItemData {
    var id: Int
    var integerPartData: ExpressionData
    var numeratorPartData: ExpressionData
    var denominatorPartData: ExpressionData

    init(integerPartData: ExpressionData, numeratorPartData: ExpressionData, denominatorPartData: ExpressionData, id: Int) {
        self.integerPartData = integerPartData
        self.numeratorPartData = numeratorPartData
        self.denominatorPartData = denominatorPartData
        self.id = id
        super.init()
    }

    required init(_ jsonObject: [String: Any]) {
        self.integerPartData = ExpressionData(jsonObject["integerPartData"] as! [String: Any])
        self.numeratorPartData = ExpressionData(jsonObject["numeratorPartData"] as! [String: Any])
        self.denominatorPartData = ExpressionData(jsonObject["denominatorPartData"] as! [String: Any])
        self.id = jsonObject["id"] as! Int
        super.init(jsonObject)
    }

    override func getDataAsJson() -> [String: Any] {
        var jsonObject: [String: Any] = [:]
        jsonObject["className"] = String(describing: Self.self)
        jsonObject["id"] = self.id
        jsonObject["integerPartData"] = self.integerPartData.getDataAsJson()
        jsonObject["numeratorPartData"] = self.numeratorPartData.getDataAsJson()
        jsonObject["denominatorPartData"] = self.denominatorPartData.getDataAsJson()
        return jsonObject
    }

    override func getDataAsQalculate() -> String {
        return "(((" + integerPartData.getDataAsQalculate() + ")*(" + denominatorPartData.getDataAsQalculate() + ")+" + numeratorPartData.getDataAsQalculate() + ")/" + denominatorPartData.getDataAsQalculate() + ")"
    }

    override func getDataAsLatex() -> String {
        return "{" + integerPartData.getDataAsLatex() + "}\\frac{" + numeratorPartData.getDataAsLatex() + "}{" + denominatorPartData.getDataAsLatex() + "}"
    }

    override func getMaxFractionLevel() -> Int {
        return max(numeratorPartData.getMaxFractionLevel() + denominatorPartData.getMaxFractionLevel() + 1, integerPartData.getMaxFractionLevel())
    }
}
