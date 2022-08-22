//
//  ContentView.swift
//  TodoList
//
//  Created by Pat on 2022/08/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        ZStack {
        
            Color.primary
                .ignoresSafeArea()
            BlobView()
                .offset(y:350)
                .blur(radius: 10)
                .opacity(0.8)
            
            HStack{
                VStack(alignment: .leading, spacing: 10){
                    Text("Today")
                        .font(.largeTitle.weight(.light))
                    Spacer()
                    
                }
                .padding()
                .frame(alignment: .leading)
                
                Spacer()
                VStack(alignment: .trailing, spacing: 5){
                    Button {
                        //TODO: - Add feature
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                            .foregroundColor(Color("DarkMode"))
                    }
                    Rectangle()
                        .frame(width: 1, height: 80)
                    Text("Week")
                    Rectangle()
                        .frame(width: 1, height: 10)
                    Text("Month")
                    Rectangle()
                        .frame(width: 1, height: 10)
                    Text("Year")
                    Spacer()
                }
                .padding()
                .frame(alignment: .trailing)
            }
            .foregroundColor(Color("DarkMode"))
            //TODO: - Add Fade when scrolling up
            ScrollView{
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text("Title")
                            .font(.title)
                            .padding(.bottom,10)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("Time")
                            .font(.caption)
                    }
                        
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, do eiusmod tempor incididunt ut labore et dolore aliqua.v")
                        .font(.callout)
                        .fontWeight(.light)
                        .lineLimit(2)
                }
                .padding()
                .rotationEffect(.degrees(180))
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
//            .foregroundColor(Color("DarkMode"))
            .offset(y:-120)
            .frame(height: 450)
            .padding()
            .rotationEffect(.degrees(180))
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


//private func addItem() {
//    withAnimation {
//        let newItem = Item(context: viewContext)
//        newItem.timestamp = Date()
//
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
//}
//
//private func deleteItems(offsets: IndexSet) {
//    withAnimation {
//        offsets.map { items[$0] }.forEach(viewContext.delete)
//
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
//}
