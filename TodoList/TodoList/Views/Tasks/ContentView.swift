//
//  ContentView.swift
//  TodoList
//
//  Created by Pat on 2022/08/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    
    @StateObject var tasksModel = TaskViewModel()
    
    @AppStorage("selectedTab") var selectedTab:Tab = .home
    @Environment(\.dismiss) var dismissal
    @Environment(\.editMode) var editButton
    /// controls the bottom states anchor positions
    @State var transitState = CGPoint(x:350, y: 0)
    @GestureState var locatioinState = CGPoint(x:350, y: 750)
    @State var dragIsActive = false
    @State var dragTransition = false
    @State var bottomState = CGSize.zero
    @State var showCard = false
    @State var showFull = false
    
    
    @FocusState var showKeyboardView : Bool
    @FocusState var isAddingItem : Bool
    @State var isDeleting = false
    @State var isArchived = false
    @State var taskTitle: String = ""
    @State var taskDescription: String = ""
    @State var taskDate: String = ""
    @State private var taskColor = Color.blue.opacity(0.5)
    
    
    var body: some View {
        ZStack {
            Group{
            BlobView()
                .offset(y:350)
                .blur(radius: 10)
                .opacity(0.8)
            //MARK: - Header Section
            TopSectionView()
            //MARK: - Body Section
            ScrollView(.vertical,showsIndicators: false){
                TodayRowCardView
            }
            .offset(y:10)
            .frame(height: 650)
            .padding()
            
            Color.black
                .ignoresSafeArea()
                .opacity(showCard ? 0.7: 0)
            
            Color.black
                .ignoresSafeArea()
                .opacity(isAddingItem ? 0.7: 0)
            }
            //MARK: - New Item View
            NewItemPopUp
            
            Group{
            //MARK: - Footer Section
            EditView(editedTask:tasksModel ,show: $showCard)
                .environmentObject(tasksModel)
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
            Color.black
                .ignoresSafeArea()
                .opacity(dragIsActive ? 0.8: 0)
            
           
            if dragIsActive{
                Circle()
                    .foregroundColor(.white)
                    .frame(width: dragTransition ? 480: 40, height: dragTransition ?  280: 40)
                    .offset(x: -150, y: 370)
                    
            }
            
            AddingNewItemButton
                .offset(x: showCard ? 300:0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: showCard)
            }
            ItemEditPopUp(messageToShow:isArchived ? "Unarchvied" : "Archived")
                .offset(y: isArchived ? 370 : 1000)
                .animation(.spring(response: 0.6, dampingFraction: 0.6), value: isArchived)
        }
        .animation(.easeInOut,value: dragIsActive)
        .onChange(of: isArchived) { V in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    isArchived = false
            }
        }
    }
    
    var AddingNewItemButton: some View{
        ZStack {
            Circle()
                .frame(width: 40, height: 40)
                .background(.black.opacity(0.9), in: Circle())
                .foregroundStyle(.ultraThinMaterial)
            Image(systemName: "plus")
                .font(.title)
                .onTapGesture {
                    isAddingItem.toggle()
                    showKeyboardView.toggle()
                }
                .foregroundColor(.white)
            if dragIsActive{
                BlobView(width: 50, height: 50)
                    .shadow(color: .white.opacity(0.9), radius: 5, x: 2, y: 2)
            }
            
        }
        .frame(width: 5, height: 5)
        .padding(.horizontal,20)
        //MARK: Gestures
        .position(locatioinState)
        .gesture(
            DragGesture()
                .onChanged{ v in
                    dragIsActive = true
                    if v.location.x < 80{
                        dragTransition.toggle()
                    }
                }
                .updating($locatioinState){currentState, pastLocation, transaction in
                    pastLocation = currentState.location
                    transaction.animation = .easeInOut
                }
                .onEnded({ v in
                    dragIsActive = false
                    dragTransition = false
                })
        )
        .animation(.spring(response: 0.3, dampingFraction: 0.7),value: dragIsActive)
        
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
                        showKeyboardView.toggle()
//                                }
                    
                }label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
            }
            .padding(15)
        }
        .background(.thinMaterial)
        .cornerRadius(30,corners: [.topLeft,.topRight])
        .padding(.horizontal,5)
        .offset(y:showKeyboardView ? 165 : 700)
        .opacity(showKeyboardView ?  1: 0)
        .animation(.spring(response: 0.6, dampingFraction: 0.6), value: showKeyboardView)
    }
    
    var TodayRowCardView: some View {
        ForEach(tasks){ task in
            
            switch selectedTab {
            case .home:
                if(task.isArchived == false && task.isCompleted == false){
                HStack(alignment: editButton?.wrappedValue == .active ? .center : .top, spacing: 10){
                    if editButton?.wrappedValue == .active{
                        VStack(spacing: 10){
                            //MARK: - Archive Button
                            Button {
                                task.isArchived.toggle()
                                try? viewContext.save()
                                editButton?.wrappedValue = .inactive
                                isArchived = true
                            } label: {
                                Image(systemName: "doc.fill.badge.plus")
                                    .font(.title3)
                                    .foregroundColor(.primary)
                            }
                            //MARK: - Delete Button
                            Button {
                                isDeleting.toggle()
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.red)
                            }
                        }
                        .alert(isPresented: $isDeleting) {
                            Alert(title: Text("Are you sure ?"),
                                  message: Text("You are about to delete a task"),
                                  primaryButton: .destructive(Text("Delete"), action: {
                                viewContext.delete(task)
                                try? viewContext.save()
                            }),
                                  secondaryButton: .default(Text("Cancel"), action: {
                                dismissal()
                            }))
                        }
                        TaskCardView(task: task)
                            .onTapGesture{
                                showCard.toggle()
                                tasksModel.editTask = task
                            }
                        
                    }else{
                        TaskCardView(task: task)
                            .onTapGesture{
                                showCard.toggle()
                                tasksModel.editTask = task
                            }
                    }
                }
                    
                }
            case .archived:
                if(task.isArchived){
                HStack(alignment: editButton?.wrappedValue == .active ? .center : .top, spacing: 10){
                    if editButton?.wrappedValue == .active{
                        VStack(spacing: 10){
                            //MARK: - Archive Button
                            Button {
                                task.isArchived.toggle()
                                try? viewContext.save()
                                editButton?.wrappedValue = .inactive
                                isArchived = true
                            } label: {
                                Image(systemName: "doc.fill.badge.plus")
                                    .font(.title3)
                                    .foregroundColor(.primary)
                            }
                            //MARK: - Delete Button
                            Button {
                                isDeleting.toggle()
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.red)
                            }
                        }
                        .alert(isPresented: $isDeleting) {
                            Alert(title: Text("Are you sure ?"),
                                  message: Text("You are about to delete a task"),
                                  primaryButton: .destructive(Text("Delete"), action: {
                                viewContext.delete(task)
                                try? viewContext.save()
                            }),
                                  secondaryButton: .default(Text("Cancel"), action: {
                                dismissal()
                            }))
                        }
                        TaskCardView(task: task)
                            .onTapGesture{
                                showCard.toggle()
                                tasksModel.editTask = task
                            }
                        
                    }else{
                        TaskCardView(task: task)
                            .onTapGesture{
                                showCard.toggle()
                                tasksModel.editTask = task
                            }
                    }
                }
                    
                }
            case .done:
                if(task.isCompleted){
                HStack(alignment: editButton?.wrappedValue == .active ? .center : .top, spacing: 10){
                    if editButton?.wrappedValue == .active{
                        VStack(spacing: 10){
                            //MARK: - Archive Button
                            Button {
                                task.isArchived.toggle()
                                try? viewContext.save()
                                editButton?.wrappedValue = .inactive
                                isArchived = true
                            } label: {
                                Image(systemName: "doc.fill.badge.plus")
                                    .font(.title3)
                                    .foregroundColor(.primary)
                            }
                            //MARK: - Delete Button
                            Button {
                                isDeleting.toggle()
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.red)
                            }
                        }
                        .alert(isPresented: $isDeleting) {
                            Alert(title: Text("Are you sure ?"),
                                  message: Text("You are about to delete a task"),
                                  primaryButton: .destructive(Text("Delete"), action: {
                                viewContext.delete(task)
                                try? viewContext.save()
                            }),
                                  secondaryButton: .default(Text("Cancel"), action: {
                                dismissal()
                            }))
                        }
                        TaskCardView(task: task)
                            .onTapGesture{
                                showCard.toggle()
                                tasksModel.editTask = task
                            }
                        
                    }else{
                        TaskCardView(task: task)
                            .onTapGesture{
                                showCard.toggle()
                                tasksModel.editTask = task
                            }
                    }
                }
                    
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(tasksModel: TaskViewModel())
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(TaskViewModel())
    }
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
                    .foregroundColor(.primary.opacity(0.8))
                Spacer()
            }
            .padding()
            .frame(alignment: .trailing)
        }
    }
}

struct TaskCardView: View {
    var task: Task
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack(){
            HStack(alignment: .top) {
                Text(task.taskTitle ?? "")
                    .font(.title3)
                    .padding(.bottom,2)
                
                Spacer()
                //MARK: - check buttons
                VStack{
                    Button {
                        task.isCompleted.toggle()
                        task.taskDate = Date()
                        try? viewContext.save()
                    } label: {
                        Image(systemName:task.isCompleted ? "checkmark.seal.fill" : "checkmark.circle")
                            .imageScale(.large)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    

                }
            }
            
            HStack(alignment: .bottom){
                VStack(alignment: .leading) {
                    Text(task.taskDescription ?? "")
                        .font(.footnote)
                        .fontWeight(.light)
                        .lineLimit(2)
                    if task.isCompleted{
                        Text("Completed on: \(task.taskDate!.formatted(.dateTime.day().month()))")
                            .font(.caption)
                            .padding(.vertical, 2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }else{
                        Text(task.taskDate?.formatted() ?? Date().formatted(.dateTime.weekday(.wide)))
                            .font(.caption)
                            .padding(.vertical, 2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}
