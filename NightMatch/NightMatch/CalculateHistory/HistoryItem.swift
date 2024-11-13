//
//  HistoryItem.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/6.
//

import SwiftUI
import LaTeXSwiftUI

struct HistoryItem: View {
    var historyBean:CalculateHistoryBean
    var deleteItem: (UUID) -> Void
    var rerunItem: (UUID) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            HStack{
                GeometryReader { geometry2 in
                    VStack{
                        HStack{
                            LaTeX("$"+historyBean.expressionDataLatexStr+"$")
                            //Text(historyBean.expressionDataLatexStr)
                                .background(Color.green)
                        }
                        .frame(height: geometry2.size.height / 2)
                        
                        GeometryReader { geometry3 in
                            HStack(spacing:0){
                                LaTeX(historyBean.decimalResult)
                                    .frame(width: geometry3.size.width / 2)
                                    .background(Color.green)
                                LaTeX(historyBean.fractionResult)
                                    .frame(width: geometry3.size.width / 2)
                                    .background(Color.gray)
                            }
                            .frame(height: geometry2.size.height / 2)
                        }
                    }
                    .frame(width:geometry.size.width * 0.6, height: geometry.size.height)
                    .background(Color.yellow)
                }
                
                VStack(spacing:15){
                    Text(LocalizedStringKey("Rerun")).onTapGesture {
                        rerunItem(historyBean.id)
                    }
                    Text(LocalizedStringKey("Copy")).onTapGesture {
                        copyItem(historyBean.id)
                    }
                    Text(LocalizedStringKey("Delete")).onTapGesture {
                        deleteItem(historyBean.id)
                    }
                }
                .frame(width:geometry.size.width * 0.4, height: geometry.size.height)
                .background(Color.blue)
            }
            .background(Color.red)
            .overlay(
                VStack {
                    if showToast {
                        Text(LocalizedStringKey("CopySuccess"))
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom, 100)
                , alignment: .bottom
            )
        }
    }
    
    @State private var showToast = false
    func copyItem(_ id:UUID) -> Void {
        UIPasteboard.general.string = HistoryUtil.loadItemExpressionDataJsonStr(id)
        self.showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showToast = false
        }
    }
}

#Preview {
    let historyBean:CalculateHistoryBean = CalculateHistoryBean(id:UUID(), expressionDataJsonStr:"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333+1", expressionDataLatexStr: "33333", fractionResult: "$"+"3"+"$", decimalResult: "$4.0000$")
    return HistoryItem(historyBean:historyBean, deleteItem: {id in
        print(id)
    }, rerunItem: {id in
        print(id)
    }).environment(\.locale, .init(identifier: "zh"))
}
