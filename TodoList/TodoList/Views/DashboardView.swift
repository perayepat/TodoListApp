//
//  DashboardView.swift
//  TodoList
//
//  Created by IACD-013 on 2022/08/24.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text("27")
                        .font(.system(size: 150, weight: .bold, design: .monospaced))
                    
                    Text("Jan")
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
                .padding()
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
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
