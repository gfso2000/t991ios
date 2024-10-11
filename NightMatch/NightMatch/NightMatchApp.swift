//
//  NightMatchApp.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/6/19.
//

import SwiftUI

@main
struct NightMatchApp: App {
    @StateObject var activeFragment:ActiveFragment = ActiveFragment()
    var body: some Scene {
        WindowGroup {
            if(activeFragment.currentFragmentName == "Calculate"){
                FragmentCalculateView().environmentObject(activeFragment)
            }else if(activeFragment.currentFragmentName == "Main"){
                FragmentMain().environmentObject(activeFragment)
            }
        }
    }
}
