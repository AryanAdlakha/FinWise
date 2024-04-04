//
//  Search.swift
//  Finwise
//
//  Created by UTKARSH NAYAN on 31/03/24.
//

import SwiftUI
import Combine

struct Search: View {
    @State private var searchText: String = ""
    @State private var filterText: String = ""
    @State private var selectCategory: Category? = nil
    
    let searchPublisher = PassthroughSubject<String, Never>()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 12, content: {
                   
                    FilterTransactionsView(category: selectCategory, searchText: filterText) { transactions in
                       
                        ForEach(transactions) { transaction in
                            NavigationLink(value: transaction) {
                                TransactionCardView(transaction: transaction, showSelectCategory: true)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                })
                .padding(15)
            }
            .overlay(content: {
                ContentUnavailableView("Search Transactions", systemImage: "magnifyingglass")
                    .opacity(filterText.isEmpty ? 1 : 0)
            })
            .onChange(of: searchText, { oldValue, newValue in
                if newValue.isEmpty {
                    filterText = ""
                }
                searchPublisher.send(newValue)
            })
            .onReceive(searchPublisher.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main), perform: { text in
                filterText = text
            })
            .searchable(text: $searchText)
            .navigationTitle("Search")
            .background(.gray.opacity(0.15))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ToolBarContent()
                }
            }
            .navigationDestination(for: Transaction.self) { transaction in
                TransactionView(editTransactions: transaction)
            }
        }
    }
    
    @ViewBuilder
    func ToolBarContent() -> some View {
        Menu {
            Button {
                selectCategory = nil
            } label: {
                HStack {
                    Text("All")
                    
                    if selectCategory == nil {
                        Image(systemName: "checkmark")
                    }
                }
            }
            
            ForEach(Category.allCases, id: \.rawValue) { category in
                Button {
                    selectCategory = category
                } label: {
                    HStack {
                        Text(category.rawValue)
                        
                        if selectCategory == category {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            Image(systemName: "slider.vertical.3")
        }
    }
}

#Preview {
    Search()
}
