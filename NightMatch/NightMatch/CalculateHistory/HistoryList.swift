//
//  HistoryList.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/6.
//

import SwiftUI

struct HistoryList: View {
    @State var historyBeanList:[CalculateHistoryBean]
    
    init() {
        //load data from disk
        historyBeanList = [
            CalculateHistoryBean(expressionDataJsonStr:"3+1", expressionDataLatexStr: "3+1", fractionResult: "4", decimalResult: "4.0000"),
            CalculateHistoryBean(expressionDataJsonStr:"333333+11", expressionDataLatexStr: "333333+11", fractionResult: "444444", decimalResult: "4.0000"),
            CalculateHistoryBean(expressionDataJsonStr:"3333+1", expressionDataLatexStr: "3333+1", fractionResult: "444", decimalResult: "44444444444444.0000")
        ]
    }
    
    var body: some View {
        VStack {
            ForEach(historyBeanList) { item in
                HistoryItem(historyBean: item, parentMethod: deleteItem)
            }
            if(historyBeanList.isEmpty){
                Text("No History Records")
            }
        }.frame(height:300)
    }
    
    func deleteItem(_ id:UUID) -> Void{
        historyBeanList.removeAll(where: {$0.id==id})
        //save to disk
    }
}

#Preview {
    HistoryList()
}
