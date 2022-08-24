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
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading){
                Text("Title".uppercased())
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundStyle(.secondary)
                    .opacity(taskTItle.isEmpty ? 0.15: 0)
                    .animation(.easeInOut, value: taskTItle)
                
                Text("Description".uppercased())
                    .padding()
                    .font(.largeTitle.bold())
                    .foregroundStyle(.secondary)
                    .opacity(taskDescription.isEmpty ? 0.15: 0)
                    .animation(.easeInOut, value: taskDescription)
             Spacer()
            }
            .frame(width: 350, height: 550, alignment: .leading)
            
            VStack{
                Spacer()
                    .frame(height: 12)
                TextField("", text: $taskTItle)
                    .padding()
//                    .overlay(
//                        HStack {
//                            Rectangle()
//                                .frame(width: 200, height: 0.5)
//                                .padding(.top,30)
//                            Spacer()
//                                .frame(width: 120)
//                        }
//                    )
                
                TextField("", text: $taskDescription)
                    .padding()
                    .padding(.top)
                    .frame(height: 450)
                    .frame(width: 350, alignment: .top)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(lineWidth: 1)
                            .padding(.horizontal,8)
                            .offset(y:10)
                    )
                Spacer()
            }
            .frame(width: 350, height: 550, alignment: .leading)
            
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(show: .constant(false))
            
    }
}
