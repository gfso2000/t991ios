//
//  MethodTwoData.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/5.
//

import Foundation

class MethodTwoData: ExpressionItemData {
    var id: Int
    var nPartData: ExpressionData
    var rPartData: ExpressionData
    var type: String

    init(nPartData: ExpressionData, rPartData: ExpressionData, id: Int, type: String) {
        self.nPartData = nPartData
        self.rPartData = rPartData
        self.id = id
        self.type = type
        super.init()
    }

    required init(_ jsonObject: [String: Any]) {
        self.nPartData = ExpressionData(jsonObject["nPartData"] as! [String: Any])
        self.rPartData = ExpressionData(jsonObject["rPartData"] as! [String: Any])
        self.id = jsonObject["id"] as! Int
        self.type = jsonObject["type"] as! String
        super.init(jsonObject)
    }

    override func getDataAsJson() -> [String: Any] {
        var jsonObject: [String: Any] = [:]
        jsonObject["className"] = String(describing: Self.self)
        jsonObject["id"] = self.id
        jsonObject["type"] = self.type
        jsonObject["nPartData"] = self.nPartData.getDataAsJson()
        jsonObject["rPartData"] = self.rPartData.getDataAsJson()
        return jsonObject
    }

    override func getDataAsQalculate() -> String {
        if type == "nCr" {
            return "comb(" + nPartData.getDataAsQalculate() + ", " + rPartData.getDataAsQalculate() + ")"
        } else if type == "nPr" {
            return "perm(" + nPartData.getDataAsQalculate() + ", " + rPartData.getDataAsQalculate() + ")"
        } else if type == "RanInt#" {
            return "randbetween(" + nPartData.getDataAsQalculate() + ", " + rPartData.getDataAsQalculate() + ")"
        } else if type == "Rec" {
            return "(" + nPartData.getDataAsQalculate() + "∠" + rPartData.getDataAsQalculate() + " degree)"
        } else if type == "Pol" {
            return "(" + nPartData.getDataAsQalculate() + "+" + rPartData.getDataAsQalculate() + "i) to polar"
        }
        return ""
    }

    override func getDataAsLatex() -> String {
        let prefix = type == "nCr" ? "C" : "P"
        return prefix + "_{" + nPartData.getDataAsLatex() + "}^{" + rPartData.getDataAsLatex() + "}"
    }

    override func getMaxFractionLevel() -> Int {
        return max(nPartData.getMaxFractionLevel(), rPartData.getMaxFractionLevel())
    }
}
