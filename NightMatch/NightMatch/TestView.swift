//
//  TestView.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/10/11.
//

import SwiftUI

struct TestView: View {
    @State private var navPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navPath) {
            Button("Jump to random") {
                navPath.append(Int.random(in: 1..<50))
            }
            .navigationDestination(for: Int.self) { i in
                Text("Int Detail \(i)")
            }
            .navigationDestination(for: String.self) { i in
                Text("String Detail \(i)")
            }

            List(1..<50) { i in
                NavigationLink(value: "Row \(i)") {
                    Label("Row \(i)", systemImage: "\(i).circle")
                }
            }
            .navigationTitle("Navigation")

        }
    }
}

#Preview {
    TestView()
}
