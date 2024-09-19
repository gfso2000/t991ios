//
//  HistoryList.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/6.
//

import SwiftUI

struct HistoryList: View {
    @Environment(\.dismiss) var dismiss
    @State var historyBeanList:[CalculateHistoryBean] = []
    var rerunItemCallback: (UUID) -> Void
    
    var body: some View {
        ScrollView {
            ForEach(historyBeanList) { item in
                HistoryItem(historyBean: item, deleteItem: deleteItem, rerunItem: rerunItem)
                    .frame(minHeight: 200)
            }
            if(historyBeanList.isEmpty){
                Text("No History Records")
            }
        }
        //.frame(height:300)
        .onAppear{
            self.historyBeanList = HistoryUtil.loadHistory()
            if(self.historyBeanList.isEmpty){
                //load sample data
                self.historyBeanList = [
                    CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"3+1", expressionDataLatexStr: "3+1", fractionResult: "4", decimalResult: "4.0000"),
                    CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", expressionDataLatexStr: "333333+11", fractionResult: "444444", decimalResult: "4.0000"),
                    CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", expressionDataLatexStr: "333333+11", fractionResult: "444444", decimalResult: "4.0000"),
                    CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", expressionDataLatexStr: "333333+11", fractionResult: "444444", decimalResult: "4.0000"),
                    CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", expressionDataLatexStr: "333333+11", fractionResult: "444444", decimalResult: "4.0000"),
                    CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", expressionDataLatexStr: "333333+11", fractionResult: "444444", decimalResult: "4.0000"),
                    CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", expressionDataLatexStr: "333333+11", fractionResult: "444444", decimalResult: "4.0000"),
                    CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", expressionDataLatexStr: "333333+11", fractionResult: "444444", decimalResult: "4.0000"),
                    CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", expressionDataLatexStr: "333333+11", fractionResult: "444444", decimalResult: "4.0000"),
                    CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", expressionDataLatexStr: "333333+11", fractionResult: "444444", decimalResult: "4.0000"),
                    CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", expressionDataLatexStr: "333333+11", fractionResult: "444444", decimalResult: "4.0000"),
                    CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", expressionDataLatexStr: "333333+11", fractionResult: "444444", decimalResult: "4.0000"),
                    CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+11", expressionDataLatexStr: "333333+11", fractionResult: "444444", decimalResult: "4.0000"),
                    CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+1", expressionDataLatexStr: "3333+1", fractionResult: "444", decimalResult: "44444444444444.0000")
                ]
            }
        }
    }
    
    func deleteItem(_ id:UUID) -> Void{
        historyBeanList.removeAll(where: {$0.id==id})
        //save to disk
        HistoryUtil.saveHistory(historyBeanList)
    }
    
    func rerunItem(_ id:UUID) -> Void{
        rerunItemCallback(id)
        dismiss()
    }
        
}

#Preview {
    HistoryList(rerunItemCallback: {id in
        print(id)
    })
}
