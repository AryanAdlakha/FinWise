import SwiftUI

struct CardView: View {
    var income: Double
    var expenses: Double
    var recurring: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.green) // Use Color.background directly as the fill
            
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Income")
                            .font(.caption)
                            .foregroundColor(.white)
                        Text(currencyString(income))
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Expenses")
                            .font(.caption)
                            .foregroundColor(.white)
                        Text(currencyString(expenses))
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.bottom, 25)
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Recurring")
                            .font(.caption)
                            .foregroundColor(.white)
                      Text(currencyString(recurring))
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

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(income: 4500, expenses: 3230, recurring: 3000)
    }
}
