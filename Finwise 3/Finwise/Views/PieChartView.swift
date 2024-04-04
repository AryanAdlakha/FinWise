import SwiftUI

struct PieChartView: View {
    @Binding var totalExpense: Double
    @Binding var need: Double
    @Binding var want: Double
    @Binding var saving: Double
    
    // Customizable colors for the pie slices
    var colors: [Color] = [Color.red, Color.yellow, Color.green]
    
    struct PieSlice: Shape {
        var startAngle: Angle
        var endAngle: Angle
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            let center = CGPoint(x: rect.midX, y: rect.midY)
            path.move(to: center)
            path.addArc(center: center, radius: min(rect.width, rect.height) / 2, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            path.closeSubpath()
            return path
        }
    }

    var body: some View {
        let needPercentage = need / totalExpense
        let wantPercentage = want / totalExpense
        let savingPercentage = saving / totalExpense
        
        GeometryReader { geometry in
            ZStack {
                PieSlice(startAngle: .degrees(0), endAngle: .degrees(360 * needPercentage))
                    .fill(colors[0])
                    .accessibilityLabel("Need: \(Int(needPercentage * 100))%")
                PieSlice(startAngle: .degrees(360 * needPercentage), endAngle: .degrees(360 * (needPercentage + wantPercentage)))
                    .fill(colors[1])
                    .accessibilityLabel("Want: \(Int(wantPercentage * 100))%")
                PieSlice(startAngle: .degrees(360 * (needPercentage + wantPercentage)), endAngle: .degrees(360))
                    .fill(colors[2])
                    .accessibilityLabel("Saving: \(Int(savingPercentage * 100))%")
            }
            .aspectRatio(1, contentMode: .fit)
            .padding()
            .animation(.easeInOut) // Add animation for a smooth transition
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Pie Chart")
    }
}

struct PieChartData {
    var need: Double
    var want: Double
    var saving: Double
}

struct PieView_Previews: PreviewProvider {
    static var previews: some View {
        let data = PieChartData(need: 750, want: 450, saving: 300)
        let totalExpense = data.need + data.want + data.saving
        return PieChartView(totalExpense: .constant(totalExpense), need: .constant(data.need), want: .constant(data.want), saving: .constant(data.saving))
    }
}
