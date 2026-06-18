//
//  SingularTextData.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/5.
//

import Foundation

class SingularTextData:ExpressionItemData{
    var id:Int
    var text:SingularTextEnum
    init(id: Int, text: SingularTextEnum) {
        self.id = id
        self.text = text
        super.init()
    }
    
//    func getText() -> String{
//        return self.text
//    }
    
    required init(_ jsonObject:[String: Any]){
        self.id = jsonObject["id"] as! Int
        self.text = SingularTextEnum.getEnumCase(by: jsonObject["text"] as! String) ?? .ZERO
        super.init(jsonObject)
    }
    override func getDataAsJson() -> [String: Any] {
        var jsonObject: [String: Any] = [:]
        jsonObject["className"] = String(describing: Self.self)
        jsonObject["id"] = self.id
        jsonObject["text"] = String(describing: self.text)
        return jsonObject
    }
    
    override func getDataAsQalculate() -> String {
        if let varAns = getVariableAnsForQalculate() {
            return varAns
        }
        return text.rawValue
    }

    func getVariableAnsForQalculate() -> String? {
        switch text {
            case .VAR_A: return "#varA#"
            case .VAR_B: return "#varB#"
            case .VAR_C: return "#varC#"
            case .VAR_D: return "#varD#"
            case .VAR_E: return "#varE#"
            case .VAR_F: return "#varF#"
            case .VAR_X: return "#varX#"
            case .VAR_Y: return "#varY#"
            case .VAR_Z: return "#varZ#"
            case .ANS: return "#varAns#"
            default:     return nil
        }
    }
    
    override func getDataAsLatex() -> String {
        if(text.rawValue == "%"){
            return "\\%";
        }
        return text.rawValue
    }
}
