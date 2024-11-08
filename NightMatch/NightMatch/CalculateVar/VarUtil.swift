//
//  VarUtil.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/10/16.
//

import Foundation

class VarUtil {
    static func resetVar(_ varName:String)->Void{
        var varBeanList:[VarBean] = VarUtil.loadVar()
        for i in 0..<varBeanList.count {
            if varBeanList[i].varName == varName {
                varBeanList[i] = VarBean(varName: varName, expressionData: ExpressionData.oneExpressionData())
            }
        }
        saveVar(varBeanList)
    }
    
    static func loadVar()->[VarBean]{
        var varBeanList:[VarBean] = []
        if let data = UserDefaults.standard.data(forKey: "varArray") {
            do {
                varBeanList = try JSONDecoder().decode([VarBean].self, from: data)
            } catch {
                print("Error loading var array: \(error.localizedDescription)")
            }
        }
        
        if varBeanList.isEmpty {
            let expressionData: ExpressionData = ExpressionData.zeroExpressionData()

            let varBeanA = VarBean(varName: String(describing: SingularTextEnum.VAR_A), expressionData: expressionData)
            let varBeanB = VarBean(varName: String(describing: SingularTextEnum.VAR_B), expressionData: expressionData)
            let varBeanC = VarBean(varName: String(describing: SingularTextEnum.VAR_C), expressionData: expressionData)
            
            let varBeanD = VarBean(varName: String(describing: SingularTextEnum.VAR_D), expressionData: expressionData)
            let varBeanE = VarBean(varName: String(describing: SingularTextEnum.VAR_E), expressionData: expressionData)
            let varBeanF = VarBean(varName: String(describing: SingularTextEnum.VAR_F), expressionData: expressionData)

            let varBeanX = VarBean(varName: String(describing: SingularTextEnum.VAR_X), expressionData: expressionData)
            let varBeanY = VarBean(varName: String(describing: SingularTextEnum.VAR_Y), expressionData: expressionData)
            let varBeanZ = VarBean(varName: String(describing: SingularTextEnum.VAR_Z), expressionData: expressionData)
            
            varBeanList.append(varBeanA)
            varBeanList.append(varBeanB)
            varBeanList.append(varBeanC)
            varBeanList.append(varBeanD)
            varBeanList.append(varBeanE)
            varBeanList.append(varBeanF)
            varBeanList.append(varBeanX)
            varBeanList.append(varBeanY)
            varBeanList.append(varBeanZ)
        }
        
        return varBeanList
    }
    
    static func saveVar(_ varBeanList:[VarBean]){
        //save to disk
        do {
            let data = try JSONEncoder().encode(varBeanList)
            UserDefaults.standard.set(data, forKey: "varArray")
        } catch {
            print("Error saving var array: \(error.localizedDescription)")
        }
    }
}
