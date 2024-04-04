import SwiftUI

struct Budget: View {
    @State private var categoryBudget: Double = 0
    @State private var overallBudget: Double = 0
    @State private var spentAmount: Double = 0
    @State private var isAddingBudget: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Button(action: {
                        isAddingBudget = true // Set the flag to show the form
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                            .padding()
                    }
                    
                    // Semicircle background with gradient
                    ZStack {
                        Circle()
                            .trim(from: 0.25, to: 0.75) // Adjust trim to start from the top
                            .stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 20)
                            .frame(width: 300, height: 300)
                            .rotationEffect(Angle(degrees: 90)) // Rotate to start from the top
                            .padding(.bottom, 100) // Adjust padding for alignment
                        
                        VStack(spacing: 20) {
                            Text("Category Budget")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            
                            Text("$\(categoryBudget, specifier: "%.2f")")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            
                            Text("Spent Amount: $\(spentAmount, specifier: "%.2f")")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    
                    // Button to update the budget
                    .sheet(isPresented: $isAddingBudget) {
                        // New view for adding budget
                        AddBudgetView(categoryBudget: $categoryBudget, overallBudget: $overallBudget, spentAmount: $spentAmount)
                    }
                    
                    // Form for additional budget details
                    Form {
                        Section(header: Text("Overall Budget")) {
                            TextField("Enter overall budget", value: $overallBudget, formatter: NumberFormatter())
                                .keyboardType(.decimalPad)
                        }

                        Section(header: Text("Spent Amount")) {
                            TextField("Enter spent amount", value: $spentAmount, formatter: NumberFormatter())
                                .keyboardType(.decimalPad)
                        }

                        Section(header: Text("Remaining Budget")) {
                            Text("Category Remaining: \(categoryBudget - spentAmount, specifier: "%.2f")")
                            Text("Overall Remaining: \(overallBudget - spentAmount, specifier: "%.2f")")
                        }
                    }
                }
            }
            .navigationTitle("Budget")
        }
    }
}

struct Budget_Previews: PreviewProvider {
    static var previews: some View {
        Budget()
    }
}
