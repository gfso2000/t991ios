//
//  ExpressionItemData.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/5.
//

import Foundation

class ExpressionItemData{
    init(){
        
    }
    required init(_ jsonObject:[String: Any]){
        
    }
    func getDataAsQalculate() -> String
    {
        return ""
    }
    
    func getDataAsJson() -> [String: Any] {
        return [:]
    }
    
    func getDataAsLatex() -> String {
        return ""
    }
}
