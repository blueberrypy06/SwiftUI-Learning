//
//  ScrollViewPractice.swift
//  Moonshot
//
//  Created by 문준민 on 11/28/26.
//

import SwiftUI

struct CategoryCard: View {
    let category: Category

    var body: some View {
        VStack (alignment: .leading) {
            Image(systemName: category.symbol)
                .font(.title.bold())
            Spacer()
            Text(category.name)
                .font(.title2.bold())
        }
        .foregroundStyle(.white)
        .padding(10)
        .frame(width: 120, height: 150, alignment: .leading)
        .background(category.color)
        .clipShape(.rect(cornerRadius: 20))
        
    }
}

struct Category: Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    let color: Color
    
    static let examples: [Category] = [
        Category(symbol: "music.note", name: "Music", color: .purple),
        Category(symbol: "airplane.up.right", name: "Travel", color: .blue),
        Category(symbol: "camera", name: "Photo", color: .green),
        Category(symbol: "book", name: "Books", color: .orange),
        Category(symbol: "dumbbell", name: "Fitness", color: .red)
    ]
}

struct ScrollViewPractice: View {
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                Text("Discover your favorite categories")
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 10) {
                        ForEach(Category.examples) { category in
                            CategoryCard(category: category)
                        }
                    }
                }
                .frame(height: 200)
            }
            .padding()
            .navigationTitle("Explore")
            
            Spacer()
        }
    }
}

#Preview {
    ScrollViewPractice()
}
