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
    @Environment(\.editMode) var editButton
    
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
                    
                        //MARK: - Edit Button
                    EditButton()
                        .foregroundColor(.black)
                    
                    
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
                HStack(alignment: editButton?.wrappedValue == .active ? .center : .top, spacing: 10){
                    
                    if editButton?.wrappedValue == .active{
                        VStack(){
                            HStack(alignment: .top) {
                                Text("Title")
                                    .font(.title)
                                    .padding(.bottom,10)
                                
                                Spacer()
                                    //MARK: - check buttom
                                Button {} label: {
                                    Image(systemName: "checkmark.circle")
                                        .imageScale(.large)
                                        .font(.caption)
                                        .foregroundStyle(.black.opacity(0.8))
                                }
                            }
                            VStack {
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, do eiusmod tempor incididunt ut labore et dolore aliqua.v")
                                    .font(.footnote)
                                    .fontWeight(.light)
                                    .lineLimit(2)
                                
                                Text("Time")
                                    .font(.caption)
                                    .padding(.vertical, 2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .rotationEffect(.degrees(180))
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                        VStack(spacing: 20){
                                //MARK: - Delete Button
                            Button {
                                    //deleting task
                                    //Saving delete
                                
                                
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.red)
                            }
                                //MARK: - Edit Button
                            Button {
                                    //deleting task
                                    //Saving delete
                                
                                
                            } label: {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.primary)
                            }
                        }
                    }else{
                        VStack(){
                            HStack(alignment: .top) {
                                Text("Title")
                                    .font(.title)
                                    .padding(.bottom,10)
                                
                                Spacer()
                                    //MARK: - check buttom
                                Button {} label: {
                                    Image(systemName: "checkmark.circle")
                                        .imageScale(.large)
                                        .font(.caption)
                                        .foregroundStyle(.black.opacity(0.8))
                                }
                            }
                            VStack {
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, do eiusmod tempor incididunt ut labore et dolore aliqua.v")
                                    .font(.footnote)
                                    .fontWeight(.light)
                                    .lineLimit(2)
                                
                                Text("Time")
                                    .font(.caption)
                                    .padding(.vertical, 2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .rotationEffect(.degrees(180))
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                            //                        .frame(height: 150)
                    }
                }
                
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
