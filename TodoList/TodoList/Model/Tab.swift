//
//  Tab.swift
//  TodoList
//
//  Created by IACD-013 on 2022/08/24.
//

import Foundation
import SwiftUI


struct TabItem: Identifiable{
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
}

enum Tab: String{
    case home
    case archived
    case done
}


var tabItems = [
    TabItem(text: "Tasks", icon: "house", tab: .home),
    TabItem(text: "Archived", icon: "list.dash", tab: .archived),
    TabItem(text: "Done", icon: "checkmark.circle.fill", tab: .done)
]
