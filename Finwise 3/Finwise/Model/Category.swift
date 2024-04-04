//
//  Category.swift
//  Finwise
//
//  Created by UTKARSH NAYAN on 30/03/24.
//


import SwiftUI

enum Category: String, CaseIterable {
    case income = "Income"
    case expenses = "Expenses"
    case recurring = "Recurring"
}

enum SelectCategory: String, CaseIterable {
    case want = "Want"
    case saving = "Saving"
    case need = "Need"
    case none = "None"
}
