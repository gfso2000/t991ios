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
                .frame(height:geometry.size.height * 0.25)
                .background(Color.blue)
                
                HStack{
                    KeyboardPanel(shiftListener:fragmentCalculateController, varListener:fragmentCalculateController, funListener:fragmentCalculateController, mainListener:fragmentCalculateController, formatListener:fragmentCalculateController, directionListener: fragmentCalculateController, undoListener: fragmentCalculateController, okExeListener: fragmentCalculateController, mathListener: fragmentCalculateController, deleteListener: fragmentCalculateController, acListener: fragmentCalculateController, historyListener: fragmentCalculateController)
                }
                .frame(height:geometry.size.height * 0.75)
                .background(Color.yellow)
            }
            .background(Color.red)
        }
    }
}

#Preview {
    FragmentCalculateView().environmentObject(ActiveFragment())
}
