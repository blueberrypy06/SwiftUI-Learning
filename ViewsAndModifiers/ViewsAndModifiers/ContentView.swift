//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by 문준민 on 10/28/26.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct ProfileCard:View {
    let name: String
    var age: Int
    
    var body: some View {
        VStack {
            Text(name)
                .font(.title)
            Text("나이: \(age)세")
        }
        .padding()
        .frame(maxWidth: 250)
        .background(.red.gradient)
        .watermarked(with: "junmin")
        .clipShape(.rect(cornerRadius: 20))
    }
}

struct ContentView: View {
    @State private var selectedNumber = ""
    let numbers = [["1", "2", "3"],
                  ["4", "5", "6"],
                  ["7", "8", "9"],
                  ["*", "0", "#"]]
    var body: some View {
        VStack(spacing: 20) {
            Text("선택한 숫자: \(selectedNumber)")
                .font(.title2)
            GridStack(rows: 4, columns: 3) { row, column in
                Button {
                    selectedNumber = numbers[row][column]
                } label: {
                    Text(numbers[row][column])
                        .font(.title)
                        .frame(width: 80, height: 80)
                        .background(.blue.opacity(0.15))
                        .clipShape(.rect(cornerRadius: 10))
                }
                .buttonStyle(.plain)
            }
        }
        
    }
}
#Preview {
    ContentView()
}

