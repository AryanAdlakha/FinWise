//
//  Chart.swift
//  Finwise
//
//  Created by UTKARSH NAYAN on 30/03/24.
//

import SwiftUI

struct ChartGroup: Identifiable {
    let id: UUID = .init()
    var date: Date
    var categories: [ChartCategory]
    var totalIncome: Double
    var totalExpense: Double
    //var totalRecurring: Double
    var totalRecurring: Double
}

struct ChartCategory: Identifiable {
    let id: UUID = .init()
    var totalValue: Double
    var category: Category
}


struct PieGroup: Identifiable {
    let id: UUID = .init()
    var date: Date
    var categories: [PieCategory]
    var totalwant: Double
    var totalneed: Double
    //var totalRecurring: Double
    var totalsaving: Double
}

struct PieCategory: Identifiable {
    let id: UUID = .init()
    var totalValu: Double
    var selectCategory: SelectCategory
}
