//
//  TestView.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import SwiftUI

struct FragmentCalculateView: View {
    let fragmentCalculateController: FragmentCalulateController = FragmentCalulateController()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing:0){
                HStack{
                    FragmentCalculateTopView(fragmentCalculateController: fragmentCalculateController)
                }
                .frame(height:geometry.size.height * 0.2)
                .background(Color.blue)
                
                HStack{
                    KeyboardPanel(directionListener: fragmentCalculateController, undoListener: fragmentCalculateController, okExeListener: fragmentCalculateController, mathListener: fragmentCalculateController, deleteListener: fragmentCalculateController, acListener: fragmentCalculateController, historyListener: fragmentCalculateController)
                }
                .frame(height:geometry.size.height * 0.8)
                .background(Color.yellow)
            }.background(Color.red)
        }
    }
}

#Preview {
    FragmentCalculateView()
}
