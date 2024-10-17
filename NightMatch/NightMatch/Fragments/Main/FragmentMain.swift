//
//  FragmentMain.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/10/11.
//

import SwiftUI

struct FragmentMainItem: View {
    @EnvironmentObject var activeFragment:ActiveFragment
    let fontUpSize = 24
    var size:CGFloat = 20
    var text:String = ""
    var image:String = ""
    
    var body: some View {
        VStack(spacing:0){
            Text(text).font(.system(size: CGFloat(fontUpSize))).foregroundColor(.white)
            Image(image).resizable().onTapGesture {
                activeFragment.currentFragmentName = text
            }
        }
        .frame(width: size/3-10, height:size/3+10)
        .background(Color.blue)
    }
}

struct FragmentMainDivider: View {
    var body: some View {
        Rectangle()
            .fill(.white)
            .frame(height: 10)
            .gridCellColumns(3)
    }
}

struct FragmentMain: View {
    let fontUpSize = 20
    var body: some View {
        GeometryReader { geometry in
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                GridRow {
                    FragmentMainItem(size: geometry.size.width, text:"Calculate", image:"fragment_main_calculate")
                    FragmentMainItem(size: geometry.size.width, text:"Calculate", image:"fragment_main_calculate")
                    FragmentMainItem(size: geometry.size.width, text:"Calculate", image:"fragment_main_calculate")
                }
                GridRow {
                    FragmentMainDivider()
                }
                GridRow {
                    FragmentMainItem(size: geometry.size.width, text:"Calculate", image:"fragment_main_calculate")
                    FragmentMainItem(size: geometry.size.width, text:"Calculate", image:"fragment_main_calculate")
                    FragmentMainItem(size: geometry.size.width, text:"Calculate", image:"fragment_main_calculate")
                }
                GridRow {
                    FragmentMainDivider()
                }
                GridRow {
                    FragmentMainItem(size: geometry.size.width, text:"Calculate", image:"fragment_main_calculate")
                    FragmentMainItem(size: geometry.size.width, text:"Calculate", image:"fragment_main_calculate")
                }
            }
            //make sure top safeArea is white
            .safeAreaInset(edge: .top) {
                Text("")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .background(.white)
            }
//            .background(Color.red)
//            .aspectRatio(1, contentMode: .fit)
//                    .border(.black, width: 1)
        }
    }
}

#Preview {
    FragmentMain().environmentObject(ActiveFragment())
}
