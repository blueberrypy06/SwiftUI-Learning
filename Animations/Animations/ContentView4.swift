//
//  ContentView4.swift
//  Animations
//
//  Created by 문준민 on 11/19/26.
//

import SwiftUI

struct ContentView4: View {
    @State private var isShowingRed = false
    var body: some View {
        VStack {
            Spacer()
            
            Button("Tap Me") {
                withAnimation(.spring(duration: 0.5)) {
                    isShowingRed.toggle()
                }
            }
            
            Spacer()
            
            if isShowingRed {
                
                VStack (spacing: 10){
                    HStack {
                        Image(systemName: "checkmark.seal")
                            .font(.title.bold())
                            .foregroundStyle(.green)
                        Text("저장되었습니다!")
                            .font(.title.bold())
                            .foregroundStyle(.green)
                    }
                    Text("변경 사항이 성공적으로 저장되었어요.")
                        .foregroundStyle(.gray)
                }
                .frame(width: 350, height: 100)
                .background(Color.green.opacity(0.3))
                .clipShape(.rect(cornerRadius: 10))
                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .opacity))
            }
        }
    }
}
#Preview {
    ContentView4()
}
