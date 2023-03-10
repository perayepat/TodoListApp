//
//  NavigationBarView.swift
//  TodoList
//
//  Created by Pat on 2022/08/31.
//

import SwiftUI

struct NavigationBarView: View {
    @AppStorage("selectedNav") var selectedNav: Destination = .tasks
    @Namespace var animation
    
    var body: some View {
        HStack {
            ForEach(navDestination){ item in
                Button{
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.6)){
                        selectedNav = item.nav
                    }
                }label: {
                    VStack(alignment: .center){
                        Image(systemName: item.icon)
                            .symbolVariant(.fill)
                            .font(selectedNav == item.nav ? .headline : .caption)
                            .padding(.bottom,5)
                            .imageScale(.small)
                        Text(selectedNav == item.nav ? "": item.text)
                            .font(.caption2)
                            .frame(width: 70)
                    }
                    .frame(width: 40, height: 30)
                    .padding(.horizontal,10)
                    .foregroundStyle(selectedNav == item.nav ? .white : .secondary)
                    .background(
                        ZStack{
                            if selectedNav == item.nav{
                                Capsule()
                                    .fill(.black)
                                    .frame(width: 40, height: 25)
                                    .offset(y: -10)
                                    .matchedGeometryEffect(id: "NAV", in: animation)
                            }
                        }
                    )
                }
            }
        }
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
    }
}
