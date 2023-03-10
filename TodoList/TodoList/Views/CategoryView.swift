//
//  CategoryView.swift
//  TodoList
//
//  Created by Pat on 2022/08/31.
//

import SwiftUI

struct CategoryView: View {
    var adjWidth:Double = 1.1
    var adjHeight:Double = 1.9
    
    var body: some View {
        VStack {
            Text("Categories")
                .font(.largeTitle.bold())
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundColor(.white)
                .frame(width: UIScreen.screenWidth / adjWidth, height: UIScreen.screenWidth / adjHeight)
                .shadow(color: .black.opacity(0.5), radius: 10, x: 10, y: 5)
                .overlay(
                    VStack(alignment: .leading){
                        Spacer()
                        Text("Routine")
                            .font(.title.bold())
                            .padding(.bottom)
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                            .lineLimit(2)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Divider()
                            .frame(width: 300)
                            .padding(.vertical)
                        HStack{
                         
                            
                            Text("Important")
                                .font(.caption2)
                                .padding(5)
                                .foregroundColor(.white)
                                .background(.black, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                            
                            Text("Sports")
                                .font(.caption2)
                                .padding(5)
                                .foregroundColor(.black)
                                .background(.black, in: RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(lineWidth: 1))
                            
                            Image(systemName: "plus.circle")
                            
                        }
                    }
                        .padding()
                )
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
