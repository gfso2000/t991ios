//
//  FxGxUtil.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/11/21.
//

import Foundation

class FxGxUtil {
    static let FX = "_f("
    static let GX = "_g("
    
    static func resetFun(_ funName:String)->Void{
        var funBeanList:[FunBean] = FxGxUtil.loadFun()
        for i in 0..<funBeanList.count {
            if funBeanList[i].funName == funName {
                funBeanList[i] = FunBean(funName: funName, expressionData: ExpressionData.oneExpressionData())
            }
        }
        saveFun(funBeanList)
    }
    
    static func loadFun()->[FunBean]{
        var funBeanList:[FunBean] = []
        if let data = UserDefaults.standard.data(forKey: "funArray") {
            do {
                funBeanList = try JSONDecoder().decode([FunBean].self, from: data)
            } catch {
                print("Error loading var array: \(error.localizedDescription)")
            }
        }
        
        if funBeanList.isEmpty {
            let expressionData: ExpressionData = ExpressionData.zeroExpressionData()

            let funBeanF = FunBean(funName: "f", expressionData: expressionData)
            let funBeanG = FunBean(funName: "g", expressionData: expressionData)
            
            funBeanList.append(funBeanF)
            funBeanList.append(funBeanG)
        }
        
        return funBeanList
    }
    
    static func saveFun(_ funBeanList:[FunBean]){
        //save to disk
        do {
            let data = try JSONEncoder().encode(funBeanList)
            UserDefaults.standard.set(data, forKey: "funArray")
        } catch {
            print("Error saving var array: \(error.localizedDescription)")
        }
    }
}
