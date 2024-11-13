//
//  FractionData.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/5.
//

import Foundation

class FractionData : ExpressionItemData{
    var id:Int
    var numeratorPartData: ExpressionData
    var denominatorPartData: ExpressionData
    
    init(numeratorPartData: ExpressionData, denominatorPartData: ExpressionData, id: Int) {
        self.numeratorPartData = numeratorPartData
        self.denominatorPartData = denominatorPartData
        self.id = id
        super.init()
    }
    
    required init(_ jsonObject: [String : Any]) {
        self.numeratorPartData = ExpressionData(jsonObject["numeratorPartData"] as! [String : Any]);
        self.denominatorPartData = ExpressionData(jsonObject["denominatorPartData"] as! [String : Any]);
        self.id = jsonObject["id"] as! Int
        super.init(jsonObject)
    }
    
//    private enum CodingKeys: String, CodingKey {
//        case id
//        case numeratorPartData
//        case denominatorPartData
//    }
//    required init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let id = try container.decode(Int.self, forKey: .id)
//        let numeratorPartData = try container.decode(ExpressionData.self, forKey: .numeratorPartData)
//        let denominatorPartData = try container.decode(ExpressionData.self, forKey: .denominatorPartData)
//
//        self.numeratorPartData = numeratorPartData
//        self.denominatorPartData = denominatorPartData
//        self.id = id
//        super.init()
//    }
//    override func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(numeratorPartData, forKey: .numeratorPartData)
//        try container.encode(denominatorPartData, forKey: .denominatorPartData)
//        try super.encode(to: encoder)
//    }
    
    override func getDataAsJson() -> [String: Any] {
        var jsonObject: [String: Any] = [:]
        jsonObject["className"] = String(describing: Self.self)
        jsonObject["id"] = self.id
        jsonObject["numeratorPartData"] = self.numeratorPartData.getDataAsJson()
        jsonObject["denominatorPartData"] = self.denominatorPartData.getDataAsJson()
        return jsonObject
    }
    
    func getNumeratorPartData() -> ExpressionData {
        return self.numeratorPartData
    }
    
    func getDenominatorPartData() -> ExpressionData {
        return self.denominatorPartData
    }
    
    override func getDataAsQalculate() -> String {
        return "(("+numeratorPartData.getDataAsQalculate()+")/("+denominatorPartData.getDataAsQalculate()+"))";
    }
    
    override func getDataAsLatex() -> String {
        return "\\frac{"+numeratorPartData.getDataAsLatex()+"}{"+denominatorPartData.getDataAsLatex()+"}";
    }
    
    override func getMaxFractionLevel() -> Int {
        return numeratorPartData.getMaxFractionLevel()+denominatorPartData.getMaxFractionLevel()+1
    }
}
