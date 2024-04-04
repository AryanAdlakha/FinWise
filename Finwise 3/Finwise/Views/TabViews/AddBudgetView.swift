//
//  AddBudgetView.swift
//  Finwise
//
//  Created by UTKARSH NAYAN on 31/03/24.
//

import SwiftUI

struct AddBudgetView: View {
    @Binding var categoryBudget: Double
    @Binding var overallBudget: Double
    @Binding var spentAmount: Double
    @State private var newCategoryBudget: Double = 0
    @State private var newOverallBudget: Double = 0
    @State private var newSpentAmount: Double = 0
    
    var body: some View {
        Form {
            Section(header: Text("New Category Budget")) {
                TextField("Enter category budget", value: $newCategoryBudget, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
            }

            Section(header: Text("New Overall Budget")) {
                TextField("Enter overall budget", value: $newOverallBudget, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
            }

            Section(header: Text("New Spent Amount")) {
                TextField("Enter spent amount", value: $newSpentAmount, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
            }
        }
        .onDisappear {
            // Update the budget values when the view disappears
            categoryBudget = newCategoryBudget
            overallBudget = newOverallBudget
            spentAmount = newSpentAmount
        }
    }
}
