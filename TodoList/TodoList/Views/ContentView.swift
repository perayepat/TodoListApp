//
//  ContentView.swift
//  TodoList
//
//  Created by Pat on 2022/08/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var taskModel: TaskViewModel
    
    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    
    @AppStorage("selectedTab") var selectedTab:Tab = .home
    @Environment(\.editMode) var editButton
    /// controls the bottom states anchor positions
    @State var bottomState = CGSize.zero
    @State var showCard = false
    @State var showFull = false
    
    @FocusState var showKeyboardView : Bool
    @FocusState var isAddingItem : Bool
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
            //MARK: - Header Section
            TopSectionView()
            //MARK: - Body Section
            ScrollView(.vertical){
                switch selectedTab {
                case .home:
//                    TodayRowCardView
//                        .onLongPressGesture(minimumDuration: 1) {
//                            showCard.toggle()
//                        }
                    ForEach(tasks){ task in
                        TaskCardView(task: task)
                    }
                case .archived:
                    Text("Archived")
                case .done:
                    Text("Done")
                }
                
            }
            .offset(y:10)
            .frame(height: 550)
            .padding()
            
            
            Color.black
                .ignoresSafeArea()
                .opacity(showCard||isAddingItem ? 0.7: 0)
            
            Color.black
                .ignoresSafeArea()
                .opacity(isAddingItem ? 0.7: 0)
            
            //MARK: - New Item View
            NewItemPopUp
            //MARK: - Footer Section
            EditView(show: $showCard)
                .offset(x: 0, y:showCard ? 360 : 1000)
                .offset(y: bottomState.height)
            //MARK: Animation
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: bottomState)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: showCard)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: showFull)
            //MARK: Gestures
                .gesture(
                    DragGesture().onChanged{ value in
                        /// store bottom card position
                        self.bottomState = value.translation
                        if self.showFull{
                            self.bottomState .height += -300
                            
                            ///maximum drag so you dont see the bottom of the card
                            if self.bottomState.height < -300
                            {
                                self.bottomState.height = -300
                            }
                        }
                    }
                    ///Reset position on drag
                        .onEnded{ value in
                            
                            ///dismiss the view with a slide
                            if self.bottomState.height > 50 {
                                self.showCard = false
                            }
                            ///show full card
                            if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull){
                                self.bottomState.height = -300 // show the full card
                                self.showFull = true
                            }
                            else {
                                self.bottomState = .zero
                                self.showFull = false
                            }
                        }
                )
            
            AddingNewItemButton
                .offset(x: showCard ? 300:0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: showCard)
        }
        
    }
    func showEditView(){
        showCard.toggle()
    }
    
    var AddingNewItemButton: some View{
        ZStack {
            Image(systemName: "plus")
                .font(.title)
                .onTapGesture {
                    isAddingItem.toggle()
                    showKeyboardView.toggle()
                }
            Circle()
                .stroke(lineWidth: 1)
                .frame(width: 40, height: 40)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottomTrailing)
        .padding(.horizontal,20)
    }
    
    var NewItemPopUp : some View{
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
                            Spacer()
                            Button{
                                
                                let newTask  = Task(context: viewContext)
                                newTask.taskTitle = taskTitle
                                newTask.taskDescription = taskDescription
                                newTask.taskDate = Date()
                                
                                taskTitle = ""
                                taskDescription = ""
                                
                                try? viewContext.save()
                                
                            }label: {
                                Image(systemName: "arrow.up.circle.fill")
                                    .imageScale(.large)
                                    .foregroundColor(.black)
                            }
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
    
    var TodayRowCardView: some View {
//        HStack(alignment: editButton?.wrappedValue == .active ? .center : .top, spacing: 10){
//
//            if editButton?.wrappedValue == .active{
//
//                VStack(spacing: 10){
//                    //MARK: - Archive Button
//                    Button {
//                        //deleting task
//                        //Saving delete
//                    } label: {
//                        Image(systemName: "doc.fill.badge.plus")
//                            .font(.title3)
//                            .foregroundColor(.primary)
//                    }
//                    //MARK: - Delete Button
//                    Button {
//                        //deleting task
//                        //Saving delete
//
//
//                    } label: {
//                        Image(systemName: "minus.circle.fill")
//                            .font(.title2)
//                            .foregroundColor(.red)
//                    }
//
//                }
//
//                ForEach(tasks){ task in
//                    TaskCardView(task: task)
//                }
//            }else{
                ForEach(tasks){ task in
                    TaskCardView(task: task)
                }
//            }
//        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(TaskViewModel())
    }
}

enum FocusableFeild: Hashable{
    case title
    case description
}


struct TopSectionView: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                TabBarView()
                Spacer()
            }
            .padding(.top,1)
            .frame(alignment: .leading)
            Spacer()
            VStack(alignment: .trailing, spacing: 5){
                //MARK: - Edit Button
                EditButton()
                    .foregroundColor(.primary)
                
                //                Rectangle()
                //                    .frame(width: 1, height: 60)
                //                Text("Week")
                //                Rectangle()
                //                    .frame(width: 1, height: 10)
                //                Text("Month")
                //             Rectangle()
                //                    .frame(width: 1, height: 10)
                //                Text("Year")
                Spacer()
            }
            .padding()
            .frame(alignment: .trailing)
        }
    }
}



struct TaskCardView: View {
    var task: Task
    var body: some View {
        VStack(){
            HStack(alignment: .top) {
                Text(task.taskTitle ?? "")
                    .font(.title2)
                    .padding(.bottom,2)

                Spacer()
                //MARK: - check buttom
                Button {
                    task.isCompleted.toggle()
                } label: {
                    Image(systemName:task.isCompleted ? "checkmark.seal.fill" : "checkmark.circle")
                        .imageScale(.large)
                        .font(.caption)
                        .foregroundStyle(.black.opacity(0.8))
                }
            }
            
            VStack {
                Text(task.taskDescription ?? "")
                    .font(.footnote)
                    .fontWeight(.light)
                    .lineLimit(2)
                
                Text(task.taskDate?.formatted(.dateTime.weekday(.wide)) ?? Date().formatted(.dateTime.weekday(.wide)))
                    .font(.caption)
                    .padding(.vertical, 2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}
