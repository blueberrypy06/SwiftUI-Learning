//
//  ContentView5.swift
//  Animations
//
//  Created by 문준민 on 11/20/26.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

struct CustomScaleModifier: ViewModifier {
    let scale: Double
    let opacity: Double
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .opacity(opacity)
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topTrailing),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

extension AnyTransition {
    static var customScale: AnyTransition {
        .modifier(
            active: CustomScaleModifier(scale: 0.2, opacity: 0),
            identity: CustomScaleModifier(scale: 1, opacity: 1)
        )
    }
}

struct ContentView5: View {
    @State private var isShowingRed = false

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
                    .zIndex(1)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
    }
}
#Preview {
    ContentView5()
}
