//
//  HistoryUtil.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/13.
//

import Foundation

class HistoryUtil{
    static func loadHistory()->[CalculateHistoryBean]{
        var historyBeanList:[CalculateHistoryBean] = []
        if let data = UserDefaults.standard.data(forKey: "historyArray") {
            do {
                historyBeanList = try JSONDecoder().decode([CalculateHistoryBean].self, from: data)
            } catch {
                print("Error loading history array: \(error.localizedDescription)")
            }
        }
        return historyBeanList
//        return [
//            CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"3+1", expressionDataLatexStr: "3+1", fractionResult: "4", decimalResult: "4.\r\n0\r\n00\r\n0\r\n"),
//            CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"+11", expressionDataLatexStr: "3\r\n3\r\n33\r\n33\r\n33\r\n33\r\n333\r\n33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", fractionResult: "444444", decimalResult: "4.0000"),
//            CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"+11", expressionDataLatexStr: "3\r\n3\r\n\r\n3\r\n33\r\n333\r\n3333\r\n333\r\n333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", fractionResult: "44\r\n\r\n\r\n4444", decimalResult: "4.\r\n\r\n\r\n\r\n\r\n0000"),
//            CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"+11", expressionDataLatexStr: "333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", fractionResult: "444444", decimalResult: "4.0000"),
//            CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"+11", expressionDataLatexStr: "333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", fractionResult: "444444", decimalResult: "4.0000"),
//            CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"+11", expressionDataLatexStr: "333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", fractionResult: "444444", decimalResult: "4.0000"),
//            CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"+11", expressionDataLatexStr: "333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", fractionResult: "444444", decimalResult: "4.0000"),
//            CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"+11", expressionDataLatexStr: "333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", fractionResult: "444444", decimalResult: "4.0000"),
//            CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"+11", expressionDataLatexStr: "333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", fractionResult: "444444", decimalResult: "4.0000"),
//            CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"+11", expressionDataLatexStr: "333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", fractionResult: "444444", decimalResult: "4.0000"),
//            CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"+11", expressionDataLatexStr: "333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", fractionResult: "444444", decimalResult: "4.0000"),
//            CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"+11", expressionDataLatexStr: "333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", fractionResult: "444444", decimalResult: "4.0000"),
//            CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"+11", expressionDataLatexStr: "333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", fractionResult: "444444", decimalResult: "4.0000"),
//            CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"+1", expressionDataLatexStr: "333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+1", fractionResult: "444", decimalResult: "44444444444444.0000")
//        ]
    }
    
    static func saveHistory(_ historyBeanList:[CalculateHistoryBean]){
        //save to disk
        do {
            let data = try JSONEncoder().encode(historyBeanList)
            UserDefaults.standard.set(data, forKey: "historyArray")
        } catch {
            print("Error saving history array: \(error.localizedDescription)")
        }
    }
    
    static func loadItemExpressionDataJsonStr(_ uuid:UUID) -> String {
        let historyBeanList:[CalculateHistoryBean] = HistoryUtil.loadHistory()
        for item in historyBeanList {
            if item.id == uuid {
                return item.expressionDataJsonStr
            }
        }
        return ""
    }
}
