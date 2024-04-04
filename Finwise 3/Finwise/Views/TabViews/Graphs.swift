//
//  Graphs.swift
//  Finwise
//
//  Created by UTKARSH NAYAN on 31/03/24.
//
import SwiftUI
import Charts
import SwiftData

struct PieView: View {
    @State private var totalExpense: Double
    @State private var need: Double
    @State private var want: Double
    @State private var saving: Double
    
    init(totalExpense: Double = 1500, need: Double = 750, want: Double = 600, saving: Double = 150) {
        self._totalExpense = State(initialValue: totalExpense)
        self._need = State(initialValue: need)
        self._want = State(initialValue: want)
        self._saving = State(initialValue: saving)
    }
    
    var body: some View {
        VStack {
            PieChartView(totalExpense: $totalExpense, need: $need, want: $want, saving: $saving)
                .frame(width: 200, height: 200) // Adjust size as needed
            
            // You can also update the data dynamically
            Button("Update Data") {
                // Example: Update the data
                totalExpense = 2000
                need = 1000
                want = 600
                saving = 400
            }
        }
    }
}


struct Graphs: View {
    @Query(animation: .snappy) private var transactions: [Transaction]
    @State private var chartGroups: [ChartGroup] = []
    //@State private var chartGroups2: [ChartGroup2] = []
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 10) {
                    ChartView()
                        .frame(height: 200)
                        .padding(10)
                        .padding(.top, 10)
                        .background(.background, in: .rect(cornerRadius: 10))
                    
                    ForEach(chartGroups) { group in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(format(date: group.date ,format:"MMM yy"))
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .hSpacing(.leading)
                            
                            NavigationLink {
                                ListOfExpenses(month: group.date)
                            } label: {
                                CardView(income: group.totalIncome, expenses: group.totalExpense, recurring: group.totalRecurring
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                 //   PieView()
                    
                    Text("Finwise Hub")
                        .font(.title)
                        .foregroundColor(.blue)
                        .padding(.top,20)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    ForEach(0..<3){
                        index in ArticleView (article: articles[index])
                    }
                }
                .padding(15)
            }
            .navigationTitle("Graphs")
            .background(.gray.opacity(0.15))
            .onAppear {
                createChartGroup()
            }
        }
    }
    
    @ViewBuilder
    func ChartView() -> some View {
        Chart {
            ForEach(chartGroups) { group in
                ForEach(group.categories) { chart in
                    BarMark(
                        x: .value("Month", format(date: group.date, format: "MMM yy")),
                        y: .value(chart.category.rawValue, chart.totalValue),
                        width: 20
                    )
                    .position(by: .value("Category", chart.category.rawValue), axis: .horizontal)
                    .foregroundStyle(by: .value("Category", chart.category.rawValue))
                }
            }
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 4)
        .chartLegend(position: .bottom, alignment: .trailing)
        .chartYAxis {
            AxisMarks(position: .leading) { value in
                let doubleValue = value.as(Double.self) ?? 0
                
                AxisGridLine()
                AxisTick()
                AxisValueLabel {
                    Text(axisLabel(doubleValue))
                }
            }
        }
        .chartForegroundStyleScale(range: [Color.green.gradient, Color.red.gradient])
    }
    
    func createChartGroup() {
        Task.detached(priority: .high) {
            let calendar = Calendar.current
            
            let groupByDate = Dictionary(grouping: transactions) { transaction in
                let components = calendar.dateComponents([.month, .year], from: transaction.dateAdded)
                
                return components
            }
            
            let sortedGroups = groupByDate.sorted {
                let date1 = calendar.date(from: $0.key) ?? .init()
                let date2 = calendar.date(from: $1.key) ?? .init()
                
                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
            }
            
            let chartGroups = sortedGroups.compactMap { dict -> ChartGroup? in
                let date = calendar.date(from: dict.key) ?? .init()
                let income = dict.value.filter({$0.category == Category.income.rawValue})
                let expense = dict.value.filter({$0.category == Category.expenses.rawValue})
               let recuring = dict.value.filter({$0.category == Category.recurring.rawValue})

                
                let incomeTotal = total(income, category: .income)
                let expenseTotal = total(expense, category: .expenses)
                let recurringTotal = total(recuring, category: .recurring)
                return .init(
                    date: date,
                    categories: [
                        .init(totalValue: incomeTotal, category: .income),
                        .init(totalValue: expenseTotal, category: .expenses)
                      //  .init(totalValue: recurringTotal, category: .recurring)
                        
                    ],
                    totalIncome: incomeTotal,
                    totalExpense: expenseTotal,
                 totalRecurring: recurringTotal
                )
            }
            
            await MainActor.run(body: {
                self.chartGroups = chartGroups
            })
        }
    }
    
    func axisLabel (_ value: Double) -> String {
        let intValue = Int(value)
        let kValue = intValue / 1000
        
        return intValue < 1000 ? "\(intValue)" : "\(kValue)K"
    }
}

struct ListOfExpenses: View {
    let month: Date
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15, content: {
                Section {
                    FilterTransactionsView(startDate: month.startOfMonth, endDate: month.endOfMonth, category: .income) { transactions in
                        ForEach(transactions) { transaction in
                            NavigationLink {
                                TransactionView(editTransactions: transaction)
                            } label: {
                                TransactionCardView(transaction: transaction)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                } header: {
                     Text("Income")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                }
                Section {
                    FilterTransactionsView(startDate: month.startOfMonth, endDate: month.endOfMonth, category: .expenses) { transactions in
                        ForEach(transactions) { transaction in
                            NavigationLink {
                                TransactionView(editTransactions: transaction)
                            } label: {
                                TransactionCardView(transaction: transaction)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                } header: {
                     Text("Expense")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                }
            })
            .padding(15)
        }
        .background(.gray.opacity(0.15))
        .navigationTitle(format(date: month, format: "MMM yy"))
    }
}

struct ArticleView: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            NavigationLink(destination: WebView(url: article.link)) {
                Image(article.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill) // Fill the available space
                    .frame(maxWidth: .infinity) // Set maximum width to fill available space
                    .frame(height: 200) // Set fixed height
                    .cornerRadius(10)
            }
            
            NavigationLink(destination: WebView(url: article.link)) {
                Text(article.title)
                    .font(.headline)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}



struct Article {
    let title: String
    let subtitle: String
    let imageName: String
    let link: URL
}

let articles = [
    Article(title: "Buy or Sell: Sumeet Bagadia Recommends Three Stocks to Buy on Monday", subtitle: "Read more at LiveMint", imageName: "stock", link: URL(string: "https://www.livemint.com/market/stock-market-news/buy-or-sell-sumeet-bagadia-recommends-three-stocks-to-buy-on-monday-1st-april-11711769530445.html")!),
    Article(title: "Technical Breakout Stocks: How to Trade Indigo, Zomato, and Thermax on Wednesday", subtitle: "Read more at Economic Times", imageName: "market", link: URL(string: "https://economictimes.indiatimes.com/markets/stocks/news/technical-breakout-stocks-how-to-trade-indigo-zomato-and-thermax-on-wednesday/articleshow/108794414.cms")!),
    Article(title: "Cryptocurrency Price on March 23: Bitcoin Holds Near $66200, BNB, XRP Jump Over 5%", subtitle: "Read more at Economic Times", imageName: "investment", link: URL(string: "https://economictimes.indiatimes.com/markets/cryptocurrency/cryptocurrency-price-on-march-23-bitcoin-holds-near-66200-bnb-xrp-jump-over-5/articleshow/108699873.cms")!)
]

#Preview {
    Graphs()
}
