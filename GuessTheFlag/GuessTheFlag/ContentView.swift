//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by 문준민 on 10/22/26.
//

import SwiftUI

struct FlagImage: View {
    let name: String
    var body: some View {
        Image(name)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct GameTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.bold))
            .foregroundStyle(.white)
    }
}

extension View {
    func gameTitleStyle() -> some View {
        modifier(GameTitleModifier())
    }
}

struct ContentView: View {
    @State private var countries = ["estonia", "france", "germany", "ireland", "italy", "nigeria", "poland", "spain", "uk", "us"].shuffled()
    @State private var correctAnswer = Int.random(in: 0..<3)
    @State private var selectedCountry = ""
    @State private var showingScore = false
    @State private var showingOver = false
    @State private var scoreTitle = ""
    @State private var selectedFlag = -1
    private var overTitle: String {
        if score >= 80 {
             return "Excellent"
        } else if score >= 50 {
            return "Good"
        } else {
            return "Try Again"
        }
    }
    @State private var score = 0
    @State private var questionIndex = 0
    private let totalQuestions = 10
    private let pointsPerCorrectAnswer = 10
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .gameTitleStyle()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer].uppercased())
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation {
                                selectedFlag = number
                            } completion: {
                                flagTapped(number)
                            }
                        }
                        label: {
                            FlagImage(name: countries[number])
                                .rotation3DEffect(.degrees(selectedFlag == number ? 360 : 0) , axis: (x: 0, y: 1, z: 0))
                                .opacity(selectedFlag == -1 || selectedFlag == number ? 1 : 0.25)
                                .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1 : 0.5)
                        }
                       
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Text("Question \(questionIndex+1)/\(totalQuestions)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                    .keyframeAnimator(
                        initialValue: 1.0,
                        trigger: questionIndex
                    ) { content, scale in
                        content.scaleEffect(scale)
                    } keyframes: { _ in
                        CubicKeyframe(1.3, duration: 0.3)
                        SpringKeyframe(1.0, duration: 0.6, spring: .bouncy)
                    }
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if (scoreTitle == "Correct") {
                Text("Your score is \(score)")
            } else {
                Text("Wrong! That’s the flag of \(selectedCountry)")
            }
        }
        .alert(overTitle, isPresented: $showingOver) {
            Button("Restart", action: reset)
        } message: {
            Text("Your final score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += pointsPerCorrectAnswer
        } else {
            scoreTitle = "Wrong"
            selectedCountry = countries[number].uppercased()
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        questionIndex += 1
        
        if questionIndex >= totalQuestions {
            showingOver = true
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            selectedFlag = -1
        }
    }
    
    func reset() {
        score = 0
        questionIndex = 0
        selectedFlag = -1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
