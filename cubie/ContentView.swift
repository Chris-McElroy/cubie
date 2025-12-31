//
//  ContentView.swift
//  cubie
//
//  Created by chris on '25.12.28.
//

import SwiftUI

struct ContentView: View {
    
    let layer: Int
    let colorA: Color
    let colorB: Color
    
    
    @State var sizeA: CGFloat = 100
    @State var sizeB: CGFloat = 100
    
    
    @State var zIndexA: CGFloat = 3
    @State var zIndexB: CGFloat = 3
    
    var body: some View {
        ZStack() {
            Color.black.zIndex(-10)
            if layer == 1 {
                ContentView(layer: 2, colorA: .pink, colorB: .black)
                    .zIndex(zIndexA+CGFloat(layer)*10)
                    .mask {
                        Rectangle()
                            .foregroundStyle(Color.blue)
                            .frame(width: sizeA, height: sizeA)
                            .padding(.trailing, 500-sizeA/2)
                            .padding(.all, 100-sizeA/2)
                            .zIndex(zIndexA+5+CGFloat(layer)*10)
                    }
            }
            Rectangle()
                .stroke(colorA, lineWidth: 50)
                .frame(width: sizeA-50, height: sizeA-50)
                .padding(.trailing, 500-sizeA/2)
                .padding(.all, 100-sizeA/2)
                .zIndex(zIndexA+1+CGFloat(layer)*10)
                .onTapGesture {
                    zIndexA = 6
                    zIndexB = 3
                    withAnimation(.easeIn(duration: 0.3)) {
                        sizeA = 1000
                    }
                }
            if layer == 1 {
                ContentView(layer: 2, colorA: .purple, colorB: .purple)
                    .zIndex(zIndexB+CGFloat(layer)*10)
                    .mask {
                        Rectangle()
                            .foregroundStyle(Color.blue)
                            .frame(width: sizeB, height: sizeB)
                            .padding(.leading, 500-sizeB/2)
                            .padding(.all, 100-sizeB/2)
                            .zIndex(zIndexB+CGFloat(layer)*10)
                    }
            }
            Rectangle()
                .stroke(colorB, lineWidth: 50)
                .frame(width: sizeB-50, height: sizeB-50)
                .padding(.leading, 500-sizeB/2)
                .padding(.all, 100-sizeB/2)
                .zIndex(zIndexB+1+CGFloat(layer)*10)
                .onTapGesture {
                    zIndexB = 6
                    zIndexA = 3
                    withAnimation(.easeIn(duration: 0.3)) {
                        sizeB = 1000
                    }
                }
            Button(action: restoreSizes) {
                Color.red
                    .overlay {
                        Text("back")
                    }
            }
            .zIndex(100)
            .buttonStyle(PlainButtonStyle())
            .focusEffectDisabled()
            .frame(width: 100, height: 40)
            .padding(.top, 400)
        }
    }
    
    func restoreSizes() {
        zIndexA = 3
        zIndexB = 3
        withAnimation(.easeOut(duration: 0.2)) {
            sizeA = 100
            sizeB = 100
        }
    }
}
