//
//  HomeView.swift
//  TodoList
//
//  Created by Pat on 2022/08/29.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("selectedNav") var selectedNav: Destination = .tasks
    let persistenceController = PersistenceController.shared
    var body: some View {
        ZStack {
          
            
            switch selectedNav {
            case .tasks:
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            case .dash:
                DashboardView()
            }
            navView
        }
    }
    
    var navView: some View{
        VStack {
            Spacer()
            HStack {
                NavigationBarView()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 200)
                    .frame(width: 200)
                    .offset(y:-40)
                    .background(
                        
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .background(.ultraThinMaterial)
                            .blur(radius: 10)
                    )
                .offset(y: 160)
                Spacer()
            }
                
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
