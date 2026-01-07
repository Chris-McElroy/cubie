//
//  AlgMenuOptionView.swift
//  cubie
//
//  Created by chris on '26.1.2.
//

import SwiftUI

struct AlgMenuOptionView: MenuOptionView {
    var title: String
    var alg: Alg
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color(hue: 1, saturation: 0, brightness: 0.1))
                .aspectRatio(1.0, contentMode: .fit)
                .shadow(color: .blue, radius: 5)
            Text(title)
        }
        .frame(width: 200, height: 200)
    }
}
