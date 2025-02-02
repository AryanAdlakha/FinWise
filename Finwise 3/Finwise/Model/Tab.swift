//
//  Tab.swift
//  ExpenseTracker
//
//  Created by Иван Легенький on 23.12.2023.
//

import SwiftUI

enum Tab: String {
    case recents = "recents"
    case search = "Filter"
    case charts = "Charts"
    case settings = "Settings"
    case budget = "Budget"
    
    @ViewBuilder
    var tabContent:some View {
        switch self {
        case .recents:
            Image(systemName: "calendar")
            Text(self.rawValue)
        case .search:
            Image(systemName: "magnifyingglass")
            Text(self.rawValue)
        case .charts:
            Image(systemName: "chart.bar.xaxis")
            Text(self.rawValue)
        case .settings:
            Image(systemName: "gearshape")
            Text(self.rawValue)
        case .budget:
            Image(systemName: "briefcase")
            Text(self.rawValue)
        }
    }
}
