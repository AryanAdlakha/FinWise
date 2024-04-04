import SwiftUI
import SwiftData

@Model
class Transaction {
    var selectCategory: String
    var subcategory: String
    var amount: Double
    var dateAdded: Date
    var category: String
    var tintColor: String
    
    init(selectCategory: SelectCategory, subcategory: String, amount: Double, dateAdded: Date, category: Category, tintColor: TintColor) {
        self.selectCategory = selectCategory.rawValue
        self.subcategory = subcategory
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }
    
    @Transient
    var color: Color {
        return tints.first(where: {$0.color == tintColor})?.value ?? appTint
    }
    
    @Transient
    var tint: TintColor? {
        return tints.first(where: {$0.color == tintColor})
    }
    
    @Transient
    var rawSelectCategory: SelectCategory? {
        return SelectCategory.allCases.first(where: {selectCategory == $0.rawValue})
    }
    
    @Transient
    var rawCategory: Category? {
        return Category.allCases.first(where: {category == $0.rawValue})
    }
}

var mockTransactions: Transaction {
    Transaction.init(selectCategory: .need, subcategory: "Apple Product", amount: 189.0, dateAdded: .now, category: .expenses, tintColor: .init(color: "Red", value: .red))
}



