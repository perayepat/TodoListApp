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
                    VStack(spacing:1){
                        Image(systemName: item.icon)
                            .symbolVariant(.fill)
                            .font(.body.bold())
                            .frame(width: 30, height: 29)
                        Text(item.text)
                            .font(.caption2)
                    }
                    .padding(.leading,20)
                    .frame(width: 130,alignment: selectedTab == item.tab ? .leading : .center)
                }
                .foregroundStyle(selectedTab == item.tab ? Color.primary: .secondary)
            }
            Spacer()
                .frame(width: 70)
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
