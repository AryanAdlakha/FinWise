//import SwiftUI
//import Charts
//import SwiftData
//
//struct ExpensePieChartView: View {
//    @Query(animation: .snappy) private var transactions: [Transaction]
//    
//    // Selected month for which to display expenses
//    @State private var selectedMonth = Date()
//
//    var body: some View {
//        ScrollView {
//            VStack {
//                DatePicker("Select Month", selection: $selectedMonth, displayedComponents: .date)
//                    .padding()
//                
//                PieChartView(data: monthlyExpenseData())
//                    .frame(height: 300)
//            }
//            .padding()
//        }
//    }
//    
//    // Function to calculate and return monthly expense data
//    func monthlyExpenseData() -> [PieChartDataEntry] {
//        // Filter transactions for the selected month
//        let transactionsForMonth = transactions.filter { transaction in
//            Calendar.current.isDate(transaction.dateAdded, equalTo: selectedMonth, toGranularity: .month)
//        }
//        
//        // Calculate total expenses for each category within the selected month
//        let totalNeed = transactionsForMonth.filter { $0.selectCategory == SelectCategory.need.rawValue }.map { $0.amount }.reduce(0, +)
//        let totalWant = transactionsForMonth.filter { $0.selectCategory == SelectCategory.want.rawValue }.map { $0.amount }.reduce(0, +)
//        let totalSaving = transactionsForMonth.filter { $0.selectCategory == SelectCategory.saving.rawValue }.map { $0.amount }.reduce(0, +)
//        
//        // Create pie chart data entries
//        let totalExpense = totalNeed + totalWant + totalSaving
//        let entries = [
//            PieChartDataEntry(value: totalNeed / totalExpense, label: "Need"),
//            PieChartDataEntry(value: totalWant / totalExpense, label: "Want"),
//            PieChartDataEntry(value: totalSaving / totalExpense, label: "Saving")
//        ]
//        
//        
//        return entries
//    }
//}
//
//struct PieChartView: UIViewRepresentable {
//    var data: [PieChartDataEntry]
//
//    func makeUIView(context: Context) -> PieChart {
//        let chartView = PieChart()
//        chartView.updateChartData(data: data)
//        return chartView
//    }
//    
//    func updateUIView(_ uiView: PieChart, context: Context) {
//        uiView.updateChartData(data: data)
//    }
//}
//
//// Dummy PieChart implementation
//class PieChart: UIView, PieChartViewProtocol {
//    func updateChartData(data: [PieChartDataEntry]) {
//        // Update the pie chart with new data
//        // This is a placeholder implementation
//        
//       
//    }
//}
//
//protocol PieChartViewProtocol {
//    func updateChartData(data: [PieChartDataEntry])
//}
//struct ExpensePieChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExpensePieChartView()
//    }
//}
