//
//  DashBoardModel.swift
//  TodoList
//
//  Created by Pat on 2022/08/31.
//

import Foundation
import SwiftUI

struct DashBoardItem: Identifiable{
    var id = UUID()
    var number: String
    var text: String
    var textSize: Int
    var width : Double
    var height : Double
    var numberAlign: HorizontalAlignment
    var wordAlign: Alignment
    var dash: Dash
}

enum Dash: String{
    case home
    case archived
    case upcoming
}

var horizontalDashItems = [
    DashBoardItem(number: "5",
                  text: "Tasks to go",
                  textSize: 50,
                  width: 2.5,
                  height: 7,
                  numberAlign: .leading,
                  wordAlign: .leading,
                  dash: .home),
    DashBoardItem(number: "8",
                  text: "Upcomming",
                  textSize: 50,
                  width: 1.8,
                  height: 7,
                  numberAlign: .leading,
                  wordAlign: .leading,
                  dash: .home)
    
]

var verticalDashItems = [
    DashBoardItem(number: "5",
                  text: "Notes",
                  textSize: 50,
                  width: 2.5,
                  height: 7,
                  numberAlign: .leading,
                  wordAlign: .leading,
                  dash: .home)
    ]
