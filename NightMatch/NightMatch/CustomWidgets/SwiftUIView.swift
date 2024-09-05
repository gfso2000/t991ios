//
//  SwiftUIView.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/21.
//

import SwiftUI

struct ContentView: View {
    @State private var bio = "Describe yourself"

    var body: some View {
        TextEditor(text: $bio)
            .frame(width:300,height:100)
            .scrollContentBackground(.hidden)
            .background(.linearGradient(colors: [.white, .gray], startPoint: .top, endPoint: .bottom))
    }
}

#Preview {
    ContentView()
}
