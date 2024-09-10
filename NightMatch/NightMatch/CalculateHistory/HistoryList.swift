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
        VStack {
            ForEach(historyBeanList) { item in
                HistoryItem(historyBean: item, deleteItem: deleteItem, rerunItem: rerunItem)
            }
            if(historyBeanList.isEmpty){
                Text("No History Records")
            }
        }
        .frame(height:300)
        .onAppear{
            if let data = UserDefaults.standard.data(forKey: "historyArray") {
                do {
                    self.historyBeanList = try JSONDecoder().decode([CalculateHistoryBean].self, from: data)
                } catch {
                    print("Error loading history array: \(error.localizedDescription)")
                }
            }
            if(self.historyBeanList.isEmpty){
                //load sample data
                self.historyBeanList = [
                    CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"3+1", expressionDataLatexStr: "3+1", fractionResult: "4", decimalResult: "4.0000"),
                    CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"333333+11", expressionDataLatexStr: "333333+11", fractionResult: "444444", decimalResult: "4.0000"),
                    CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"3333+1", expressionDataLatexStr: "3333+1", fractionResult: "444", decimalResult: "44444444444444.0000")
                ]
            }
        }
    }
    
    func deleteItem(_ id:UUID) -> Void{
        historyBeanList.removeAll(where: {$0.id==id})
        //save to disk
        do {
            let data = try JSONEncoder().encode(historyBeanList)
            UserDefaults.standard.set(data, forKey: "historyArray")
        } catch {
            print("Error saving history array: \(error.localizedDescription)")
        }
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
