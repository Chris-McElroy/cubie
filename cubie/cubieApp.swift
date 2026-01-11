//
//  cubieApp.swift
//  cubie
//
//  Created by chris on '25.12.28.
//

import SwiftUI
import RealityKit

@main
struct cubieApp: App {
    @State var angle: CGFloat = 45.0
    
    var body: some SwiftUI.Scene {
        WindowGroup {
            ZStack {
                Color.black
                TestView()
                VStack {
                    Text("testing")
                    Spacer()
                }
            }
        }
    }
}
