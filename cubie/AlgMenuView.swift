//
//  AlgMenuView.swift
//  cubie
//
//  Created by chris on '25.12.28.
//

import SwiftUI

struct AlgMenuView: View {
    @State var options: [MenuOptionView] = [
        MenuOptionView(title: "U right", header: "what?", subOptions: [
            MenuOptionView(title: "U left", header: "where?", subOptions: []),
            MenuOptionView(title: "D up", header: "where?", subOptions: []),
        ]),
        MenuOptionView(title: "U left", header: "what?", subOptions: []),
        MenuOptionView(title: "U down", header: "what?", subOptions: []),
        MenuOptionView(title: "D down", header: "what?", subOptions: []),
        MenuOptionView(title: "D left", header: "what?", subOptions: []),
        MenuOptionView(title: "D right", header: "what?", subOptions: []),
    ]
    
    
    var body: some View {
        Grid(horizontalSpacing: 100, verticalSpacing: 100) {
            GridRow {
                ForEach(0..<4) { i in
                    if options.count >= (8 - i) {
                        options[8 - i - 1]
                            .onTapGesture {
                                options = options[8 - i - 1].subOptions
                            }
                    } else {
                        MenuOptionView(title: "", header: "", subOptions: [])
                    } // TODO make menuoptionview and alg be subclasses of abstract class, and add a header, and figure out a way to go back
                }
            }
            GridRow {
                ForEach(4..<8) { i in
                    if options.count >= 8 - i {
                        options[8 - i - 1]
                            .onTapGesture {
                                options = options[8 - i - 1].subOptions
                            }
                    } else {
                        MenuOptionView(title: "", header: "", subOptions: [])
                    }
                }
            }
        }
        .padding(100)
    }
}
