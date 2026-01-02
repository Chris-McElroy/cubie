//
//  AlgMenuView.swift
//  cubie
//
//  Created by chris on '25.12.28.
//

import SwiftUI

struct AlgMenuView: View {
    @State var header: String = "where is the bottom right corner facing?"
    @State var options: [MenuOptionView] = [
        SubMenuOptionView(title: "U right", header: "what?", subOptions: [
            SubMenuOptionView(title: "U left", header: "where?", subOptions: []),
            SubMenuOptionView(title: "D up", header: "where?", subOptions: []),
        ]),
        SubMenuOptionView(title: "U left", header: "what?", subOptions: [
            AlgMenuOptionView(title: "cool!")
        ]),
        SubMenuOptionView(title: "U down", header: "what?", subOptions: []),
        SubMenuOptionView(title: "D down", header: "what?", subOptions: []),
        SubMenuOptionView(title: "D left", header: "what?", subOptions: []),
        SubMenuOptionView(title: "D right", header: "what?", subOptions: []),
    ]
    
    
    var body: some View {
        VStack {
            Text(header)
                .onTapGesture {
                    header = "where is the bottom right corner facing?"
                    options = [
                        SubMenuOptionView(title: "U right", header: "what?", subOptions: [
                            SubMenuOptionView(title: "U left", header: "where?", subOptions: []),
                            SubMenuOptionView(title: "D up", header: "where?", subOptions: []),
                        ]),
                        SubMenuOptionView(title: "U left", header: "what?", subOptions: [
                            AlgMenuOptionView(title: "cool!")
                        ]),
                        SubMenuOptionView(title: "U down", header: "what?", subOptions: []),
                        SubMenuOptionView(title: "D down", header: "what?", subOptions: []),
                        SubMenuOptionView(title: "D left", header: "what?", subOptions: []),
                        SubMenuOptionView(title: "D right", header: "what?", subOptions: []),
                    ]
                }
            Spacer()
            Grid(horizontalSpacing: 100, verticalSpacing: 100) {
                GridRow {
                    ForEach(0..<4) { i in
                        if options.count >= (8 - i) {
                            if let subMenuOption = options[8 - i - 1] as? SubMenuOptionView {
                                subMenuOption
                                    .onTapGesture {
                                        options = subMenuOption.subOptions
                                    }
                            } else if let algMenuOption = options[8 - i - 1] as? AlgMenuOptionView {
                                algMenuOption
                                    .onTapGesture {
                                        print(algMenuOption.title)
                                    }
                            }
                        } else {
                            SubMenuOptionView(title: "", header: "", subOptions: [])
                        }
                    }
                }
                GridRow {
                    ForEach(4..<8) { i in
                        if options.count >= (8 - i) {
                            if let subMenuOption = options[8 - i - 1] as? SubMenuOptionView {
                                subMenuOption
                                    .onTapGesture {
                                        options = subMenuOption.subOptions
                                    }
                            } else if let algMenuOption = options[8 - i - 1] as? AlgMenuOptionView {
                                algMenuOption
                                    .onTapGesture {
                                        print(algMenuOption.title)
                                    }
                            }
                        } else {
                            SubMenuOptionView(title: "", header: "", subOptions: [])
                        }
                    }
                }
            }
        }
        .padding(100)
        .padding()
    }
}
