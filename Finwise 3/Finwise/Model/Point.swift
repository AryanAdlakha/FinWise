//
//  Point.swift
//  Finwise
//
//  Created by UTKARSH NAYAN on 30/03/24.
//

import SwiftUI

struct Point: Identifiable {
    let id: UUID = .init()
    let symbol: String
    let title: String
    let subtitle: String
}

let points: [Point] = [
    .init(symbol: "creditcard", title: "Financial Records", subtitle: "Effectively monitor your income and outflows with meticulous detail."),
    .init(symbol: "chart.bar", title: "Data Visualization", subtitle: "Easily grasp financial trends with captivating charts showcasing your data."),
    .init(symbol: "doc.text.viewfinder", title: "Customized Filtering", subtitle: "Swiftly identify specific expenses through sophisticated search and filtering features"),
]

