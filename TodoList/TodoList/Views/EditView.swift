//
//  EditView.swift
//  TodoList
//
//  Created by IACD-013 on 2022/08/23.
//

import SwiftUI

struct EditView: View {
//    var focusField: FocusState<UUID?>.Binding
    @Binding var show: Bool
    @State var taskTItle: String = ""
    @State var taskDescription: String = ""
    @Environment(\.dismiss) var dismiss
    
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
                }label: {
                    Image(systemName: "circle")
                        .font(.title2.weight(.light))
                        .foregroundColor(.black)
                }
                TextField("Title", text: $taskTItle)
                Spacer()
            }
            .padding()
            
            HStack{
                Image(systemName: "calendar")
                    .font(.title2.bold())
                    .foregroundStyle(.black.opacity(0.3))
                Text("Task Date")
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
        
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(show: .constant(false))
            .preferredColorScheme(.dark)
            
    }
}