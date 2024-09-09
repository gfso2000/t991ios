//
//  GrowingButtonStyle.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/14.
//

import SwiftUI

struct GrowingButtonStyle2: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(5)
            .background(Color(red: 37 / 255, green: 37 / 255, blue: 37 / 255))
            .foregroundStyle(.white)
            .cornerRadius(6)
            .overlay(
                LeftTopStrokeShape()
                    .stroke(Color.yellow, lineWidth: 6)
                    .cornerRadius(6)
            )
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


