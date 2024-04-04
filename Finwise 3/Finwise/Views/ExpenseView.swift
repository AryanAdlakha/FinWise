import SwiftUI

struct ExpenseView: View {
    var need: Double
    var want: Double
    var saving: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.green) // Use Color.background directly as the fill
            
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Expense on Needs")
                            .font(.caption)
                            .foregroundColor(.white)
                        Text(currencyString(need))
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Expense on Wants")
                            .font(.caption)
                            .foregroundColor(.white)
                        Text(currencyString(want))
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.bottom, 25)
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Expense on savings")
                            .font(.caption)
                            .foregroundColor(.white)
                      Text(currencyString(saving))
                            .font(.title3)
                           .fontWeight(.bold)
                           .foregroundColor(.primary)
                    }
                    
                    Spacer()
                }
            }
            .padding([.horizontal, .bottom], 25)
            .padding(.top, 15)
        }
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView(need: 2000, want: 3000, saving: 4500)
    }
}
