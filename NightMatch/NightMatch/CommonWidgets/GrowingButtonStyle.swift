//
//  GrowingButtonStyle.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/14.
//

import SwiftUI

struct GrowingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(5)
            .background(.blue)
            .foregroundStyle(.white)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6).fill(Color.gray)
                    .mask(
                        HStack(spacing:0) {
                            Rectangle().frame(width: 3)
                            VStack(spacing:0){
                                Rectangle().frame(height: 3)
                                Spacer()
                            }
                        }
                    ).allowsHitTesting(false)
            )
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


