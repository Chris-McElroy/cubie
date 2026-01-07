//
//  EditMenuOption.swift
//  cubie
//
//  Created by chris on '26.1.4.
//

import SwiftUI

struct EditMenuOption: View {
    @State var menuOption: SubMenuOptionView
    
    var body: some View {
        VStack(spacing: 100) {
            Text("title:")
            TextField("add title", text: $menuOption.title)
            Text("header:")
            TextField("add header", text: $menuOption.header)
        }
    }
}
