//
//  SubMenuOptionView.swift
//  cubie
//
//  Created by chris on '26.1.1.
//

import SwiftUI

struct SubMenuOptionView: MenuOptionView {
    let title: String
    let header: String
    let subOptions: [any MenuOptionView]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color(hue: 1, saturation: 0, brightness: 0.1))
                .aspectRatio(1.0, contentMode: .fit)
                .shadow(color: .yellow, radius: 5)
            Text(title)
        }
    }
}

typealias AlgSet = SubMenuOptionView
