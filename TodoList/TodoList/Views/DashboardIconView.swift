//
//  DashboardIconView.swift
//  TodoList
//
//  Created by Pat on 2022/08/31.
//

import SwiftUI

struct DashboardIconView: View {
    var dashItem = verticalDashItems[0]
    var body: some View {
        RoundedRectangle(cornerRadius: 25, style: .continuous)
            .stroke(lineWidth: 1)
            .frame(width: UIScreen.screenWidth / dashItem.width, height: UIScreen.screenHeight / dashItem.height)
            .overlay(
                VStack(alignment: dashItem.numberAlign ,spacing:10){
                    Text(dashItem.number)
                        .font(.system(size: CGFloat(dashItem.textSize) , weight: .bold))
                        .offset(y: 20)
                        .padding(.horizontal)
                    Spacer()
                    Rectangle()
                        .cornerRadius(25, corners: [.bottomLeft,.bottomRight])
                        .frame(height: UIScreen.screenHeight/17)
                        .overlay(
                            VStack {
                                
                                Text(dashItem.text)
                                    .frame(maxWidth: .infinity, alignment: dashItem.wordAlign)
                                    .foregroundColor(.white)
                                    .font(.title3.bold())
                                    .padding(.horizontal)
                            }
                        )
                }
            )
    }
}

struct DashboardIconView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardIconView()
    }
}
