//
//  EditView.swift
//  TodoList
//
//  Created by IACD-013 on 2022/08/23.
//

import SwiftUI

struct EditView: View {
//    var focusField: FocusState<UUID?>.Binding
    
    var editedTask: TaskViewModel
    @Binding var show: Bool
    @State var taskTitle: String = ""
    @State var taskDate: String = ""
    @State var taskDescription: String = ""
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .foregroundColor(.black)
                .opacity(0.1)
            HStack {
                Text("Title")
                    .bold()
                    .foregroundStyle(.black.opacity(0.6))
                Spacer()
                Button{
                    //MARK: - Save Changes
                    if taskTitle == "title"{
                        
                    }else{
                    editedTask.editTask?.taskTitle = taskTitle
                    editedTask.editTask?.taskDescription = taskDescription
//                    taskTitle = ""
//                    taskDescription = ""
                    
                    try? viewContext.save()
                        
                    }
                    show.toggle()
                }label: {
                    Text("Save")
                        .font(.caption.bold())
                        .padding(10)
                        .background(.black.opacity(0.2) , in: RoundedRectangle(cornerRadius: 25, style: .continuous))
                        .foregroundColor(.black.opacity(0.5))
                }
                Button{
                    show.toggle()
                }label: {
                    Image(systemName: "xmark")
                        .font(.caption.bold())
                        .padding(10)
                        .background(.black.opacity(0.2) , in: Circle())
                        .foregroundColor(.black.opacity(0.5))
                }
            }
            .padding()
            HStack{
                Button{
                    //MARK: - mark as done
                    editedTask.editTask?.isCompleted.toggle()
                    
                }label: {
                    Image(systemName: editedTask.editTask?.isCompleted ?? false ? "circle.fill" : "circle")
                        .font(.title2.weight(.light))
                        .foregroundColor(.black)
                }
                TextField("Title", text: $taskTitle)
                Spacer()
            }
            .padding()
            
            HStack{
                Image(systemName: "calendar")
                    .font(.title2.bold())
                    .foregroundStyle(.black.opacity(0.3))
                Text(taskDate)
                    .font(.caption)
                    .foregroundStyle(.black.opacity(0.3))
                Spacer()
            }
            .padding(.horizontal)
            Divider()
                .frame(width: 350)
                .padding(.vertical)
            HStack{
                Text("Description")
                    .bold()
                    .foregroundStyle(.black.opacity(0.6))
                Spacer()
            }
            .padding()
            TextField("Task Description", text: $taskDescription)
                .padding()
        }
        .padding(.top,8)
        .padding(.horizontal,10)
        .frame(maxHeight: .infinity,alignment: .top)
        .background(.white)
        .cornerRadius(30,corners: [.topLeft,.topRight])
        .shadow(radius: 20)
        .onAppear{
            if let task = editedTask.editTask {
                taskTitle =  task.taskTitle ?? ""
                taskDescription =  task.taskDescription ?? ""
                taskDate = task.taskDate?.formatted() ?? ""
            }
        }
        .onChange(of: show) { newValue in
            if let task = editedTask.editTask {
                taskTitle =  task.taskTitle ?? ""
                taskDescription =  task.taskDescription ?? ""
                taskDate = task.taskDate?.formatted() ?? ""
            }
        }
        
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(editedTask: TaskViewModel(), show: .constant(false))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(TaskViewModel())
            .preferredColorScheme(.dark)
            
    }
}
