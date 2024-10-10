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
