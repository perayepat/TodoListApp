//
//  TodoListApp.swift
//  TodoList
//
//  Created by Pat on 2022/08/22.
//

import SwiftUI

@main
struct TodoListApp: App {
    let persistenceController = PersistenceController.shared
    @State var isActive: Bool = false

    var body: some Scene {
        WindowGroup {
            
            if isActive {
                HomeView()
            } else{
                SplashScreenView(isActive: $isActive)
            }
            
        }
    }
}
