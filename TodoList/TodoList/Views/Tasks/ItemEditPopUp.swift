//
//  ItemEditPopUp.swift
//  TodoList
//
//  Created by Pat on 2022/08/30.
//

import SwiftUI

struct ItemEditPopUp: View {
    var messageToShow = "Archived"
    var body: some View {
        Text(messageToShow)
            .foregroundColor(.black)
            .padding()
            .background(.white, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

struct ItemEditPopUp_Previews: PreviewProvider {
    static var previews: some View {
        ItemEditPopUp()
            
    }
}
