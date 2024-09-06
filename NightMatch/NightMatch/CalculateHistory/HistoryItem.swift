//
//  HistoryItem.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/9/6.
//

import SwiftUI

struct HistoryItem: View {
    var historyBean:CalculateHistoryBean
    var parentMethod: (UUID) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            HStack{
                GeometryReader { geometry2 in
                    VStack{
                        HStack{
                            Text(historyBean.expressionDataLatexStr)
                                .background(Color.green)
                        }
                        .frame(height: geometry2.size.height / 2)
                        
                        GeometryReader { geometry3 in
                            HStack(spacing:0){
                                Text(historyBean.decimalResult)
                                    .frame(width: geometry3.size.width / 2)
                                    .background(Color.green)
                                Text(historyBean.fractionResult)
                                    .frame(width: geometry3.size.width / 2)
                                    .background(Color.gray)
                            }
                            .frame(height: geometry2.size.height / 2)
                        }
                    }
                    .frame(width:geometry.size.width * 0.6, height: geometry.size.height)
                    .background(Color.yellow)
                }
                
                VStack{
                    Text("Rerun")
                    Text("Copy")
                    Text("Delete").onTapGesture {
                        parentMethod(historyBean.id)
                    }
                }
                .frame(width:geometry.size.width * 0.4, height: geometry.size.height)
                .background(Color.blue)
            }
            .background(Color.red)
        }
    }
}

#Preview {
    let historyBean:CalculateHistoryBean = CalculateHistoryBean(expressionDataJsonStr:"3+1", expressionDataLatexStr: "3+1", fractionResult: "4", decimalResult: "4.0000")
    return HistoryItem(historyBean:historyBean, parentMethod: {id in
        print(id)
    })
}
