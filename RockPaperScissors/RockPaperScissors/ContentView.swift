//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by 문준민 on 11/3/26.
//

import SwiftUI

struct ContentView: View {
    private let rockPaperScissors = ["✊", "✌️", "✋"]
    @State private var computerSelected = Int.random(in: 0...2) {
        didSet(oldValue) {
            if computerSelected == oldValue {
                computerSelected = Int.random(in: 0...2)
            }
        }
    }
    @State private var roundRequire = ["Win", "Lose"].shuffled()
    @State private var round = 1
    @State private var score = 0 {
        didSet {
            if score < 0 {
                score = 0
            }
        }
    }
    @State private var showingRoundOver = false
    @State private var showingGameOver = false
    @State private var scoreTitle = ""
    private var gameOverTitle: String {
        if score > 8 {
            return "Excellent!"
        } else if score > 5 {
            return "Good!"
        } else {
            return "Try Again!"
        }
    }
    
    private let totalRound = 10
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [((roundRequire[0] == "Win") ? .green : .red), .white, .gray], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("Rock! Paper! Scissors!")
                    .font(.largeTitle.weight(.bold))
                
                Spacer()
                
                VStack {
                    Text("Require: \(roundRequire[0])")
                        .font(.title.weight(.heavy))
                    Text("Computer's Select:")
                        .font(.title2.weight(.heavy))
                    Text(rockPaperScissors[computerSelected])
                        .font(.system(size: 80))
                }
                
                Spacer()
                
                VStack (spacing: 20){
                    ForEach(rockPaperScissors, id: \.self) { type in
                        Button {
                            checker(type)
                        }
                        label:  {
                            Text(type)
                                .font(.system(size: 60))
                                .frame(width: 130, height: 100)
                                .background(Color.black.opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                    }
                }
                
                Spacer()
                Spacer()
                
                VStack {
                    Text ("Score: \(score)")
                        .font(.title.weight(.bold))
                    Text("Round: \(round)/\(totalRound)")
                        .font(.title.weight(.bold))
                }
            }
            .padding()
            .alert(scoreTitle, isPresented: $showingRoundOver) {
                Button ("Continue", action: nextRound)
            }
            .alert(gameOverTitle, isPresented: $showingGameOver) {
                Button("Restart", action: reset)
            }
            message: {
                Text("Your Final Score is \(score)")
            }
        }
    }
    
    func nextRound() {
        if round >= totalRound {
            showingGameOver = true
        } else {
            round += 1
            computerSelected = Int.random(in: 0...2)
            roundRequire.shuffle()
        }
    }
    
    func reset() {
        score = 0
        round = 1
        computerSelected = Int.random(in: 0...2)
        roundRequire.shuffle()
    }
    
    func checker(_ me: String) {
        let computer = rockPaperScissors[computerSelected]
        let didWin = isWin(me)
        let didDraw = me == computer

        let isCorrect = roundRequire[0] == "Win"
            ? didWin
            : (!didWin && !didDraw)

        score += isCorrect ? 1 : -1
        scoreTitle = isCorrect ? "Success" : "Fail"

        showingRoundOver = true
    }
    
    func isWin(_ me: String) -> Bool {
        let computer = rockPaperScissors[computerSelected]

        switch computer {
        case "✊":
            return me == "✋"
        case "✌️":
            return me == "✊"
        case "✋":
            return me == "✌️"
        default:
            return false
        }
    }
}

#Preview {
    ContentView()
}
