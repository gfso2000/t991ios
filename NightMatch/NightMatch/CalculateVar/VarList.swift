//
//  VarList.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/10/16.
//

import SwiftUI

struct VarList: View {
    @Environment(\.dismiss) var dismiss
    @State var varBeanList:[VarBean] = []
    var selectItemCallback: (SingularTextEnum) -> Void
    
    var body: some View {
        ScrollView {
            ForEach(varBeanList) { item in
                VarItem(varBean: item, selectItem: selectItem, resetItem: resetItemCallback)
                    .frame(minHeight: 50)
            }
        }
        .onAppear{
            self.varBeanList = VarUtil.loadVar()
        }
    }
    
    func resetItemCallback(_ varName:String) -> Void{
        //save to disk
        VarUtil.resetVar(varName)
        self.varBeanList.removeAll()
        self.varBeanList = VarUtil.loadVar()
    }
    
    func selectItem(_ varName:SingularTextEnum) -> Void{
        selectItemCallback(varName)
        dismiss()
    }
}

#Preview {
    VarList(selectItemCallback: {id in
        print(id)
    })
}
