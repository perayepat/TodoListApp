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
    case dashboard
}


var tabItems = [
    TabItem(text: "Home", icon: "house", tab: .home),
    TabItem(text: "Dashboard", icon: "list.dash", tab: .dashboard)
]
