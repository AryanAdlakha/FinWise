//
//  FinwiseApp.swift
//  Finwise
//
//  Created by UTKARSH NAYAN on 30/03/24.
//

import SwiftUI

@main
struct FinwiseApp: App {
    var body: some Scene {
        WindowGroup {
            RootView {
                ContentView()
                    .onAppear {
                        //WidgetCenter.shared.reloadAllTimelines()
                    }
            }
        }
        .modelContainer(for: Transaction.self) // Error occurs here
        }
    
}
