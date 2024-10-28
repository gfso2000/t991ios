//
//  TestView.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/10/11.
//

import SwiftUI

struct MyData {
    let age:Int
    var name:String
    
    mutating func setName(_ newName:String){
        self.name = newName
    }
}
struct TestView: View {
    @State var myData = MyData(age: 1, name: "a")
    @State private var navPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navPath) {
            Button(myData.name) {
                //myData.name = "a"
                self.myData.setName("z")
                print(self.myData.name)
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
