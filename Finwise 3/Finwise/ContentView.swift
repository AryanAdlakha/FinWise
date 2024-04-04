//
//  ContentView.swift
//  Finwise
//
//  Created by UTKARSH NAYAN on 30/03/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("lockWhenAppInBg") private var lockWhenAppInBg: Bool = false
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    @State private var activeTab: Tab = .recents
    @State private var data = PieChartData(need: 2000, want: 3000, saving: 4500)
    var body: some View {
        LockView(lockType: .both, lockPin: "0000", isEnabled: isAppLockEnabled, lockWhenAppGoesBackground: lockWhenAppInBg, content: {
            TabView(selection: $activeTab) {
                Recents().tag(Tab.recents)
                    .tabItem { Tab.recents.tabContent }
                Search()
                    .tag(Tab.search)
                    .tabItem { Tab.search.tabContent }
                Graphs()
                    .tag(Tab.charts)
                    .tabItem { Tab.charts.tabContent }
                Budget()
                    .tag(Tab.budget)
                    .tabItem { Tab.budget.tabContent }
                Settings()
                    .tag(Tab.settings)
                    .tabItem { Tab.settings.tabContent }
                
            }
            .tint(appTint)
            .sheet(isPresented: $isFirstTime, content: {
                IntroScreen()
                    .interactiveDismissDisabled()
            })
            .preferredColorScheme(userTheme.colorScheme)
        })
    }
}

#Preview {
    RootView {
        ContentView()
    }
}


  
   
       
