//
//  TransactionView.swift
//  Finwise
//
//  Created by UTKARSH NAYAN on 30/03/24.
//

import SwiftUI
import WidgetKit

struct TransactionView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var editTransactions: Transaction?
    
    @State private var selectCategory: SelectCategory = .none
    @State private var subcategory: String = ""
    @State private var amount: Double = .zero
    @State private var dateAdded: Date = .now
    @State private var category: Category = .income
    @State private var isInfoPopoverPresented: Bool = false // Flag to present the popover

    @State var tint: TintColor = tints.randomElement()!
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                Text("Preview")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .hSpacing(.leading)
                
                TransactionCardView(transaction: .init(
                    selectCategory: selectCategory,
                    subcategory: subcategory.isEmpty ? "SubCategory" : subcategory,
                    amount: amount,
                    dateAdded: dateAdded,
                    category: category,
                    tintColor: tint
                ))
               // CustomSection("Select-Category", "Apple Product", value: $subcategory)
                SelectCategoryCheckBox()
                
            
                    Button(action: {
                                     isInfoPopoverPresented = true // Set the flag to show the popover
                                 }) {
                                     HStack {
                                         CustomSection("Sub-Category", "Apple Product", value: $subcategory)
//                                         Text("Budget")
//                                             .font(.title)
//                                             .fontWeight(.bold)
//                                             .foregroundColor(.blue)
                                         Image(systemName: "info.circle")
                                             .foregroundColor(.blue)
                                     }
                                 }
                                 .padding()
                                 .popover(isPresented: $isInfoPopoverPresented) {
                                     VStack {
//                                         Text("Budget Information")
//                                             .font(.headline)
//                                             .padding()
                                         ExpenseListView()                                             .padding()
                                     }
                                 

//
//                    
                   
                    
                    
                }
                
                VStack(alignment: .leading, spacing: 10 ,content: {
                    Text("Amount & Expense-Sector")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    VStack(spacing: 15) {
                        HStack(spacing: 4) {
                            Text(currencySymbol)
                                .font(.callout.bold())
                            
                            TextField("0.0", value: $amount, formatter: numberFormatter)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                        .frame(maxWidth: 130)
                        
                        CategoryCheckBox()
                    }
                })
                
                VStack(alignment: .leading, spacing: 10 ,content: {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    DatePicker("", selection: $dateAdded, displayedComponents: [.date])
                        .datePickerStyle(.wheel)
                        .padding(.horizontal, 12)
                    
                        .padding(.vertical, 10)
                        .background(.background, in: .rect(cornerRadius: 10))
                })
            }
            .padding(15)
        }
        .navigationTitle("\(editTransactions != nil ? "Edit" : "Add") Transaction")
        .background(.gray.opacity(0.15))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button("Save", action: save)
            })
        })
        .onAppear(perform: {
            if let editTransactions {
                if let selectCategory = editTransactions.rawSelectCategory {
                    self.selectCategory = selectCategory
               }
//            if let tint = editTransactions.tint {
//                    self.tint = tint
//                }
                subcategory = editTransactions.subcategory
                amount = editTransactions.amount
                dateAdded = editTransactions.dateAdded
                if let category = editTransactions.rawCategory {
                    self.category = category
                }
                if let tint = editTransactions.tint {
                    self.tint = tint
                }
            }
        })
    }
    
    @ViewBuilder
    func CategoryCheckBox() -> some View {
        HStack(spacing: 10) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                HStack(spacing: 5) {
                    ZStack {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundStyle(appTint)
                        
                        if self.category == category {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundStyle(appTint)
                        }
                    }
                    Text(category.rawValue)
                        .font(.caption)
                }
                .contentShape(.rect)
                .onTapGesture {
                    self.category = category
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .hSpacing(.leading)
        .background(.background, in: .rect(cornerRadius: 10))
    }
    @ViewBuilder
    func SelectCategoryCheckBox() -> some View {
        HStack(spacing: 10) {
            ForEach(SelectCategory.allCases, id: \.rawValue) { SelectCategory in
                HStack(spacing: 5) {
                    ZStack {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundStyle(appTint)
                        
                        if self.selectCategory == SelectCategory {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundStyle(appTint)
                        }
                    }
                    Text(SelectCategory.rawValue)
                        .font(.caption)
                }
                .contentShape(.rect)
                .onTapGesture {
                    self.selectCategory = SelectCategory
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .hSpacing(.leading)
        .background(.background, in: .rect(cornerRadius: 10))
    }
    
    @ViewBuilder
    func CustomSection(_ title: String, _ hint: String, value: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
            
            TextField(hint, text: value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(.background, in: .rect(cornerRadius: 10))
        })
    }
    
    func save() {
        if editTransactions != nil {
            editTransactions?.selectCategory = selectCategory.rawValue
            editTransactions?.subcategory = subcategory
            editTransactions?.amount = amount
            editTransactions?.category = category.rawValue
            editTransactions?.dateAdded = dateAdded
            Toast.shared.present(title: "Note Changed", symbol: "scribble")
        } else {
            let transaction = Transaction(
                selectCategory: selectCategory,
                subcategory: subcategory,
                amount: amount,
                dateAdded: dateAdded,
                category: category,
                tintColor: tint
            )
            
            context.insert(transaction)
            Toast.shared.present(title: "Note Created", symbol: "plus")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            WidgetCenter.shared.reloadAllTimelines()
        }

        dismiss()
    }
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        formatter.currencySymbol = "₴ "
        
        return formatter
    }
}

#Preview {
    TransactionView()
}
