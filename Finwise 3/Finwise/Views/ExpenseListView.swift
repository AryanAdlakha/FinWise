//
//  ExpenseListView.swift
//  Finwise
//
//  Created by UTKARSH NAYAN on 03/04/24.
//

import SwiftUI

struct ExpenseListView: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 20) {
                Text("For income please select none.")
                    .font(.headline)
                Text("Needs:")
                    .font(.headline)
                    .foregroundColor(.green)
                needsList()
                Text("Wants:")
                    .font(.headline)
                    .foregroundColor(.green)

                wantsList()
                Text("Savings:")
                    .font(.headline)
                    .foregroundColor(.green)

                savingsList()
            }
            .padding()
        }
    }
    
    func needsList() -> some View {
        let needs = [
            "Housing (rent/mortgage payments, utilities)",
            "Food (groceries, essential supplies)",
            "Transportation (commuting costs, vehicle expenses)",
            "Health care (insurance premiums, medication)",
            "Basic clothing and personal care items",
            "Insurance (life insurance, health insurance, etc.)",
            "Minimum debt payments (credit cards, loans)"
        ]
        
        return VStack(alignment: .leading, spacing: 5) {
            ForEach(needs, id: \.self) { need in
                Text(need)
            }
        }
    }
    
    func wantsList() -> some View {
        let wants = [
            "Entertainment (dining out, movies, concerts)",
            "Travel (vacations, non-essential trips)",
            "Non-essential clothing and accessories",
            "Hobbies and leisure activities",
            "Eating out at restaurants or ordering takeout",
            "Subscription services (streaming, magazines, etc.)",
            "Home decor and luxury items"
        ]
        
        return VStack(alignment: .leading, spacing: 5) {
            ForEach(wants, id: \.self) { want in
                Text(want)
            }
        }
    }
    
    func savingsList() -> some View {
        let savings = [
            "Emergency fund contributions",
            "Retirement savings (401(k), IRA contributions)",
            "Investments (stocks, bonds, mutual funds)",
            "Education savings (college funds, tuition savings)",
            "Saving for specific goals (buying a house, starting a business)"
        ]
        
        return VStack(alignment: .leading, spacing: 5) {
            ForEach(savings, id: \.self) { saving in
                Text(saving)
            }
        }
    }
}

struct ExpenseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseListView()
    }
}
