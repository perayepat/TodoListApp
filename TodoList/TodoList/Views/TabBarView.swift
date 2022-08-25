//
//  TabBarView.swift
//  TodoList
//
//  Created by IACD-013 on 2022/08/24.
//

import SwiftUI
struct TabBarView: View {
    @AppStorage("selectedTab") var selectedTab:Tab = .home
    @Namespace var animation
    
    var body: some View {
        HStack {
            ForEach(tabItems){ item in
                Button{
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)){
                        selectedTab = item.tab
                    }
                }label: {
                        Image(systemName: item.icon)
                            .symbolVariant(.fill)
                            .font(.body.bold())
                            .frame(width: 30, height: 30)
                        Text(item.text)
                            .font(.caption2)
                }
                .padding(.horizontal,10)
                .foregroundStyle(selectedTab == item.tab ? Color.white: .secondary)
                .background(
                    ZStack{
                        if selectedTab == item.tab{
                            Capsule()
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                )
            }
        }
        
        .background(
            Capsule()
                .stroke(lineWidth: 0.3)
        )
        .padding()
        .ignoresSafeArea()
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
