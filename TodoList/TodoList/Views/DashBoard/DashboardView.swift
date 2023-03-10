//
//  DashboardView.swift
//  TodoList
//
//  Created by IACD-013 on 2022/08/24.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                VStack {
                    Text("1")
                        .font(.system(size: 150, weight: .bold, design: .monospaced))
                    
                    Text("Sep")
                        .font(.system(size: 40, weight: .bold))
                    
                }
                .padding(1)
                
                HStack{
                    Text("Groups")
                        .padding(10)
                        .background(.black, in: RoundedRectangle(cornerRadius: 20, style: .continuous).stroke())
                    Spacer()
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                        
                }
                .padding(.horizontal)
                
                Divider()
                    .padding()
                VStack(alignment: .leading){
                    HStack{
                        ForEach(horizontalDashItems){ item in
                            DashboardIconView(dashItem: item)
                        }
                    }
                    Spacer()
                        .frame(height: 15)
                    HStack(alignment: .top){
                        ForEach(verticalDashItems){ item in
                            
                            DashboardIconView(dashItem: item)
                        }
                    }
                    VStack{
                        Text("Recent Tasks")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding()
                        
                        ForEach(0 ..< 3) { item in
                            VStack(alignment:.leading){
                                Text("Task title")
                                    .font(.body.bold())
                                    .padding(.bottom)
                                    
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ")
                                    .font(.subheadline)
                            }
                            .padding()
                            .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
                        }

                        
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom,200)
        }
        
        
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .previewLayout(.sizeThatFits)
    }
}
