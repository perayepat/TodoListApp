//
//  SplashScreenView.swift
//  TodoList
//
//  Created by Pat on 2022/08/28.
//

import SwiftUI

struct SplashScreenView: View {
    @Binding  var isActive:Bool
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        VStack {
            VStack{
                SplashScreenIconView()
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear{
                withAnimation(.easeInOut){
                    self.size = 0.9
                    self.opacity = 1.0
                }
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.isActive = true
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView(isActive: .constant(false))
    }
}
