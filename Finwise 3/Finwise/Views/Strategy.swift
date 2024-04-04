////
////  Graphs.swift
////  Finwise
////
////  Created by UTKARSH NAYAN on 31/03/24.
////
//import SwiftUI
//import Charts
//import SwiftData
//
//struct Strategy: View {
//    @Query(animation: .snappy) private var transactions: [Transaction]
//    @State private var pieGroups: [PieGroup] = []
//
//    var body: some View {
//        NavigationStack {
//            ScrollView(.vertical) {
//                LazyVStack(spacing: 10) {
//                    pieView()
//                        .frame(height: 300)
//                        .padding(10)
//                        .padding(.top, 10)
//                        .background(Color.gray.opacity(0.15))
//                    
//                    ForEach(pieGroups) { group in
//                        VStack(alignment: .leading, spacing: 10) {
//                            Text(format(date: group.date, format: "MMM yy"))
//                                .font(.caption)
//                                .foregroundStyle(.gray)
//                                .hSpacing(.leading)
//                            
//                            NavigationLink {
//                                ListOfExpenses1(month: group.date)
//                            } label: {
//                                ExpenseView(need: group.totalneed, want: group.totalwant, saving: group.totalsaving)
//                            }
//                            .buttonStyle(.plain)
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Graphs")
//            .background(Color.gray.opacity(0.15))
//            .onAppear {
//                createChartGroup()
//            }
//        }
//    }
//    
//    @ViewBuilder
//    func pieView() -> some View {
//        if !pieGroups.isEmpty {
//            PieChartView(data: pieChartData())
//                .frame(height: 300)
//                .padding(10)
//                .padding(.top, 10)
//                .background(Color.gray.opacity(0.15))
//        } else {
//            Text("No data available")
//                .foregroundColor(.gray)
//                .frame(heigwant300)
//                .padding(10)
//                .padding(.top, 10)
//                .background(Color.gray.opacity(0.15))
//        }
//    }
//
//    func pieChartData() -> [PieChartDataEntry] {
//        // Calculate total expenses for each category
//        let totalNeed = pieGroups.map { $0.totalneed }.reduce(0, +)
//        let totalWant = pieGroups.map { $0.totalwant }.reduce(0, +)
//        let totalSaving = pieGroups.map { $0.totalsaving }.reduce(0, +)
//        
//        // Create pie chart data entries
//        let entries = [
//            PieChartDataEntry(value: totalNeed, label: "Need"),
//            PieChartDataEntry(value: totalWant, label: "Want"),
//            PieChartDataEntry(value: totalSaving, label: "Saving")
//        ]
//        
//        return entries
//    }
//
//    func createChartGroup() {
//        Task.detached(priority: .high) {
//            let calendar = Calendar.current
//            
//            let groupByDate = Dictionary(grouping: transactions) { transaction in
//                let components = calendar.dateComponents([.month, .year], from: transaction.dateAdded)
//                
//                return components
//            }
//            
//            let sortedGroups = groupByDate.sorted {
//                let date1 = calendar.date(from: $0.key) ?? .init()
//                let date2 = calendar.date(from: $1.key) ?? .init()
//                
//                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
//            }
//            
//            let pieGroups = sortedGroups.compactMap { dict -> PieGroup? in
//                let date = calendar.date(from: dict.key) ?? .init()
//                let need = dict.value.filter({$0.selectCategory == SelectCategory.need.rawValue})
//                let want = dict.value.filter({$0.selectCategory == SelectCategory.want.rawValue})
//                let saving = dict.value.filter({$0.selectCategory == SelectCategory.saving.rawValue})
//                
//                let needTotal = total(need, category: .expenses)
//                let wantTotal = total(want, category: .expenses)
//                let savingTotal = total(saving, category: .expenses)
//                
//                return PieGroup(
//                    date: date,
//                    categories: [
//                        .init(totalValu: needTotal, selectCategory: .need),
//                        .init(totalValu: wantTotal, selectCategory: .want),
//                        .init(totalValu: savingTotal, selectCategory: .saving)
//                    ],
//                    totalwant: wantTotal, totalneed: needTotal,
//                    totalsaving: savingTotal
//                )
//            }
//            
//            await MainActor.run(body: {
//                self.pieGroups = pieGroups
//            })
//        }
//    }
//}
//
//struct ListOfExpenses1: View {
//    let month: Date
//    
//    var body: some View {
//        ScrollView(.vertical) {
//            LazyVStack(spacing: 15, content: {
//                Section {
//                    FilterTransactionsView(startDate: month.startOfMonth, endDate: month.endOfMonth, category: .income) { transactions in
//                        ForEach(transactions) { transaction in
//                            NavigationLink {
//                                TransactionView(editTransactions: transaction)
//                            } label: {
//                                TransactionCardView(transaction: transaction)
//                            }
//                            .buttonStyle(.plain)
//                        }
//                    }
//                } header: {
//                     Text("Need")
//                        .font(.caption)
//                        .foregroundStyle(.gray)
//                        .hSpacing(.leading)
//                }
//                Section {
//                    FilterTransactionsView(startDate: month.startOfMonth, endDate: month.endOfMonth, category: .expenses) { transactions in
//                        ForEach(transactions) { transaction in
//                            NavigationLink {
//                                TransactionView(editTransactions: transaction)
//                            } label: {
//                                TransactionCardView(transaction: transaction)
//                            }
//                            .buttonStyle(.plain)
//                        }
//                    }
//                } header: {
//                     Text("Want")
//                        .font(.caption)
//                        .foregroundStyle(.gray)
//                        .hSpacing(.leading)
//                }
//                Section {
//                    FilterTransactionsView(startDate: month.startOfMonth, endDate: month.endOfMonth, category: .expenses) { transactions in
//                        ForEach(transactions) { transaction in
//                            NavigationLink {
//                                TransactionView(editTransactions: transaction)
//                            } label: {
//                                TransactionCardView(transaction: transaction)
//                            }
//                            .buttonStyle(.plain)
//                        }
//                    }
//                } header: {
//                     Text("Saving")
//                        .font(.caption)
//                        .foregroundStyle(.gray)
//                        .hSpacing(.leading)
//                }
//            })
//            .padding(15)
//        }
//        .background(.gray.opacity(0.15))
//        .navigationTitle(format(date: month, format: "MMM yy"))
//    }
//}
//
//struct Strategy_Previews: PreviewProvider {
//    static var previews: some View {
//        Strategy()
//    }
//}
