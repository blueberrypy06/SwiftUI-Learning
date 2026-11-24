//
//  ContentView.swift
//  Animations
//
//  Created by 문준민 on 11/16/26.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0
    @State private var isFlipped = false
    @State private var selectedAxis = "X"
    private let axis = ["X", "Y", "Z"]
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            
            Button("Tap Me") {
                withAnimation(.spring(duration: 1, bounce: 0.5)) {
                    animationAmount += 360
                    isFlipped.toggle()
                }
            }
            .padding(50)
            .background(isFlipped ? .green : .red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(isFlipped ? 1.2 : 1.0)
            .rotation3DEffect(
                .degrees(animationAmount), axis: (
                    x: selectedAxis == "X" ? 1 : 0,
                    y: selectedAxis == "Y" ? 1 : 0,
                    z: selectedAxis == "Z" ? 1 : 0))
            
            Spacer()
            
            
            VStack {
                Text("Selected Axis: \(selectedAxis)")
                    .font(.title2.bold())
                HStack {
                    Picker("Axis", selection: $selectedAxis) {
                        ForEach(axis, id:\.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
                .padding()
            }
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
