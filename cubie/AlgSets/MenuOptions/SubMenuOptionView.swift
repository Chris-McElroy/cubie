//
//  SubMenuOptionView.swift
//  cubie
//
//  Created by chris on '26.1.1.
//

import SwiftUI

struct SubMenuOptionView: MenuOptionView {
    var title: String
    var header: String
    var subOptions: [any MenuOptionView]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color(hue: 1, saturation: 0, brightness: 0.1))
                .aspectRatio(1.0, contentMode: .fit)
                .shadow(color: .yellow, radius: 5)
            Text(title)
        }
        .frame(width: 200, height: 200)
    }
}

typealias AlgSet = SubMenuOptionView
