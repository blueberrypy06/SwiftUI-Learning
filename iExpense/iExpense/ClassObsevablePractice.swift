//
//  ClassObsevablePractice.swift
//  iExpense
//
//  Created by 문준민 on 11/25/26.
//
import SwiftUI

@Observable
class Player {
    var name: String = "Player 1"
    var level: Int = 1
    var score: Int = 0
    var maxScore: Int {
        return 50 * ((level - 1) / 2)
    }
    
    func reset() {
        level = 1
        score = 0
    }
    
    func addScore() {
        score += 10
        if score >= maxScore {
            score -= maxScore
            level += 1
        }
    }
}

struct ClassObsevablePractice: View {
    @Environment(\.dismiss) var dismiss
    @State private var player = Player()

    var body: some View {
        VStack {
            HStack {
                Text("Player Profile")
                    .font(.title2.bold())
                Spacer()
            }
            .padding()
            
            VStack(spacing: 5) {
                Image(systemName: "person.circle")
                    .font(.title)
                Text("\(player.name)")
                    .font(.title.bold())
                Text("Level \(player.level)")
                    .font(.callout)
            }
            
            HStack(){
                Text("Name")
                    .font(.callout.bold())
                
                TextField(
                    "Player Name",
                    text:$player.name
                    )
                .multilineTextAlignment(.trailing)
            
            }
            .padding()
            
            HStack(){
                Text("Score")
                    .font(.callout.bold())
                Spacer()
                Text("\(player.score)")
            }
            .padding()
            
            VStack {
                Button {
                    player.addScore()
                }
                label: {
                    Text("Add Score +10")
                        .foregroundStyle(.white)
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .clipShape(.rect(cornerRadius: 20))
                        .padding()
                }
                
                Button {
                    player.reset()
                }
                label: {
                    Text("Reset Player")
                        .foregroundStyle(.black)
                        .font(.title3.bold())
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 500)
        .background(Color.gray.opacity(0.2))
        .clipShape(.rect(cornerRadius: 20))
        .padding()
        
        Button("Dissmiss") {
            dismiss()
        }
        .font(.callout.bold())
        .foregroundStyle(.black)
        .frame(width: 150, height: 50)
        .background(Color.gray.opacity(0.5))
        .clipShape(.rect(cornerRadius:20))
    }
}

#Preview {
    ClassObsevablePractice()
}
