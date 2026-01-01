//
//  ContentView.swift
//  cubie
//
//  Created by chris on '25.12.28.
//

import SwiftUI

struct ContentView: View {
    let colorDict: [Int: [Color]] = [
        0: [.blue, .green],
        1: [.pink, .black],
        2: [.purple, .purple],
        8: [.red, .yellow],
        9: [.black, .brown],
        10: [.orange, .orange],
    ]
    
    @State var layer: Int = 0
    
    
    var body: some View {
        ZStack {
            Color.black
            HStack(spacing: 20) {
                Rectangle()
                    .foregroundStyle(colorDict[layer]![0])
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        switch layer {
                        case 0: layer = 1
                        case 1: layer = 8
                        case 8: layer = 9
                        default: break
                        }
                    }
                Rectangle()
                    .foregroundStyle(colorDict[layer]![1])
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        switch layer {
                        case 0: layer = 2
                        case 8: layer = 10
                        default: break
                        }
                    }
            }
            Button(action: restoreSizes) {
                Color.red
                    .overlay {
                        Text("back")
                    }
            }
            .buttonStyle(PlainButtonStyle())
            .focusEffectDisabled()
            .frame(width: 100, height: 40)
            .padding(.top, 400)
        }
    }
    
    func restoreSizes() {
        switch layer {
        case 8: layer = 1
        case 9: layer = 8
        case 10: layer = 8
        default: layer = 0; break
        }
    }
}
