//
//  ContentView.swift
//  cubie
//
//  Created by chris on '25.12.28.
//

import SwiftUI

struct ContentView: View {
    @State var sizeA: CGFloat = 100
    @State var sizeB: CGFloat = 100
    
    
    @State var zIndexA: CGFloat = 2
    @State var zIndexB: CGFloat = 1
    
    var body: some View {
        ZStack() {
            Rectangle()
                .foregroundStyle(Color.green)
                .frame(width: sizeA, height: sizeA)
                .padding(.trailing, 500-sizeA/2)
                .padding(.all, 100-sizeA/2)
                .zIndex(zIndexA)
            Rectangle()
                .foregroundStyle(Color.blue)
                .frame(width: sizeB, height: sizeB)
                .padding(.leading, 500-sizeB/2)
                .padding(.all, 100-sizeB/2)
                .zIndex(zIndexB)
            Button(action: changeSizes) {
                Color.red
                    .overlay {
                        Text("press me")
                    }
            }
            .buttonStyle(PlainButtonStyle())
            .focusEffectDisabled()
            .frame(width: 100, height: 40)
            .padding(.top, 400)
        }
        .padding()
        .onAppear {
        }
    }
    
    func changeSizes() {
        withAnimation(.easeIn(duration: 1.0)) {
            sizeA = 1000
        }
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            withAnimation(.easeIn(duration: 1.0)) {
                sizeA = 100
            }
        }
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            zIndexA = 1.0
            zIndexB = 2.0
            withAnimation(.easeIn(duration: 1.0)) {
                sizeB = 1000
            }
        }
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            withAnimation(.easeIn(duration: 1.0)) {
                sizeB = 100
            }
        }
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { _ in
            zIndexB = 1.0
            zIndexA = 2.0
            withAnimation(.easeIn(duration: 1.0)) {
                sizeA = 1000
            }
        }
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
            withAnimation(.easeIn(duration: 1.0)) {
                sizeA = 100
            }
        }
    }
}
