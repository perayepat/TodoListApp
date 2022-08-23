//
//  ContentView.swift
//  TodoList
//
//  Created by Pat on 2022/08/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    
    @FocusState var showKeyboardView : Bool
    @State var taskTitle: String = ""
    @State var taskDescription: String = ""
    @State var taskDate: String = ""
    @State private var taskColor = Color.blue.opacity(0.5)
    
    
    var body: some View {
        ZStack {
            
            
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
                        showKeyboardView.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .foregroundColor(Color("DarkMode"))
                    }
                    .tint(.none)
                    Rectangle()
                        .frame(width: 1, height: 60)
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
            //TODO: - Add Fade when scrolling up
            ScrollView{
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text("Title")
                            .font(.title)
                            .padding(.bottom,10)
                        
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
            .offset(y:-120)
            .frame(height: 450)
            .padding()
            .rotationEffect(.degrees(180))
            //MARK: - New Item View
            VStack {
                TextField("Title", text: $taskTitle)
                    .focused($showKeyboardView)
                    .padding(.horizontal)
                    .font(.body)
                    .padding([.horizontal,.top])
                TextField("Description", text: $taskDescription)
                    .padding(.horizontal)
                    .focused($showKeyboardView)
                    .font(.caption)
                    .padding()
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            HStack{
                                Image(systemName: "calendar.badge.plus")
                                    .imageScale(.large)
                                Image(systemName: "eyedropper")
                                    .imageScale(.large)
                                Spacer()
                                Image(systemName: "arrow.up.circle.fill")
                                    .imageScale(.large)
                                
                            }
                            .padding(10)
                        }
                    }
            }
            .background(.thinMaterial)
            .cornerRadius(30,corners: [.topLeft,.topRight])
            .padding(.horizontal,5)
            .offset(y:showKeyboardView ? 165 : 700)
            .opacity(showKeyboardView ?  1: 0)
            .animation(.spring(response: 0.6, dampingFraction: 0.6), value: showKeyboardView)

        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

enum FocusableFeild: Hashable{
    case title
    case description
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
