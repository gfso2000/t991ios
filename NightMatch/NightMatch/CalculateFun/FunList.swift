//
//  VarList.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/10/16.
//

import SwiftUI

struct FunList: View {
    @Environment(\.dismiss) var dismiss
    @State var funBeanList:[FunBean] = []
    var selectItemCallback: (String) -> Void
    
    var body: some View {
        ScrollView {
            ForEach(funBeanList) { item in
                FunItem(funBean: item, selectItem: selectItem, resetItem: resetItemCallback)
                    .frame(minHeight: 50)
            }
        }
        .onAppear{
            self.funBeanList = FxGxUtil.loadFun()
        }
    }
    
    func resetItemCallback(_ funName:String) -> Void{
        //save to disk
        VarUtil.resetVar(funName)
        self.funBeanList.removeAll()
        self.funBeanList = FxGxUtil.loadFun()
    }
    
    func selectItem(_ funName:String) -> Void{
        selectItemCallback(funName)
        dismiss()
    }
}

#Preview {
    FunList(selectItemCallback: {id in
        print(id)
    })
}
