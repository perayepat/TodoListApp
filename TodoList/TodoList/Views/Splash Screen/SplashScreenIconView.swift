//
//  SplashScreen.swift
//  TodoList
//
//  Created by Pat on 2022/08/28.
//

import SwiftUI

struct SplashScreenIconView: View {
    var body: some View {
        ZStack{
            Group{
                GifImage("appIcon")
            }
            .frame(width: 320, height: 320)
        }
        .ignoresSafeArea()
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenIconView()
    }
}


