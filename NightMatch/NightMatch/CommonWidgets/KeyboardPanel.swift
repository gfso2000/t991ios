//
//  KeyboardPanel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/14.
//

import SwiftUI

struct KeyboardPanel: View {
    var body: some View {
        VStack(spacing:0){
            HStack(spacing:0){
                Button("Press Me") {
                    print("Button pressed!")
                }
                .buttonStyle(GrowingButtonStyle())
            }
        }
    }
}

#Preview {
    KeyboardPanel()
}
