//
//  MainView.swift
//  Animations
//
//  Created by 문준민 on 11/19/26.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            ContentView()
                .tabItem {
                    Image(systemName: "1.circle")
                }
            ContentView2()
                .tabItem {
                    Image(systemName: "2.circle")
                }
            ContentView3()
                .tabItem {
                    Image(systemName: "3.circle")
                }
            ContentView4()
                .tabItem {
                    Image(systemName: "4.circle")
                }
        }
        .tint(.blue)
    }
}

#Preview {
    MainView()
}
