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
                Button {
                    print("Button pressed!")
                }label: {
                    Text("Del").frame(maxWidth: .infinity)
                }
                .buttonStyle(GrowingButtonStyle())
                Button() {
                    print("Button pressed!")
                }label: {
                    Text("⬆︎").frame(maxWidth: .infinity)
                }
                .buttonStyle(GrowingButtonStyle())
                Button() {
                    print("Button pressed!")
                }label: {
                    Text("Undo").frame(maxWidth: .infinity)
                }
                .buttonStyle(GrowingButtonStyle())
            }
            HStack(spacing:0){
                Button("⬅︎") {
                    print("Button pressed!")
                }
                .buttonStyle(GrowingButtonStyle())
                Button("OK") {
                    print("Button pressed!")
                }
                .buttonStyle(GrowingButtonStyle())
                Button("➡︎") {
                    print("Button pressed!")
                }
                .buttonStyle(GrowingButtonStyle())
            }
            HStack(spacing:0){
                Button("X") {
                    print("Button pressed!")
                }
                .buttonStyle(GrowingButtonStyle())
                Button("⬇︎") {
                    print("Button pressed!")
                }
                .buttonStyle(GrowingButtonStyle())
                Button("X") {
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
