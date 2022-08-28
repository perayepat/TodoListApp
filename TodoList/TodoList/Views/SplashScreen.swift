//
//  SplashScreen.swift
//  TodoList
//
//  Created by Pat on 2022/08/28.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack{
            Color(hex: "E8E4D6")
            
            Group{
                GifImage("appIcon")
            }
            .frame(width: 220, height: 130)
        }
        .ignoresSafeArea()
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}


