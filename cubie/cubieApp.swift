//
//  cubieApp.swift
//  cubie
//
//  Created by chris on '25.12.28.
//

import SwiftUI

@main
struct cubieApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(layer: 1, colorA: .green, colorB: .blue)
        }
    }
}
