//
//  ContentView.swift
//  Times Table
//
//  Created by 문준민 on 11/22/26.
//


import SwiftUI

struct BackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.gray.opacity(0.1))
            .clipShape(.rect(cornerRadius: 20))
    }
}

extension View {
    func backgroundStyle() -> some View {
        modifier(BackgroundModifier())
    }
}

struct ContentView: View {
    @State private var gameStart = false
    
    // 게임 설정
    @State private var selectedTable = 2    // 단 선택
    private let questionNum = [5, 10, 20]
    @State private var selectedQuestionCount = 5  // 총 문제 수 선택
    
    private var scoreStep: Int {
        100 / selectedQuestionCount
    }
    
    // 초기화 해야 하는 값들
    @State private var score = 0
    @State private var questionIndex = 1
    @State private var userAnswer = ""
    @State private var correctQuestion = 0
    
    // 랜덤으로 생성되는 문제 배열
    @State private var question = [Int]()
    
    @State private var showingAlert = false
    
    // 입력 키 배치
    private let numberRows = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["⌫", "0", ""]
    ]
    
    
    var body: some View {
        VStack {
            Text("Time Table Learning!")
                .font(.largeTitle.bold())
            
            // 게임 설정 뷰
            if !gameStart {
                VStack {
                    Text("Game Setting")
                        .font(.headline)
                    Stepper("\(selectedTable) 단 선택",
                            value: $selectedTable,
                            in:2...12)
                    VStack (alignment: .leading) {
                        Text("문제 수 선택")
                        Picker("문제 수 선택", selection: $selectedQuestionCount) {
                            ForEach(questionNum, id:\.self) { num in
                                Text("\(num)")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                .backgroundStyle()
                
                Button {
                    Start()
                }
                label: {
                    Text("게임 시작!")
                        .font(.title3.bold())
                        .foregroundStyle(Color.primary)
                        .frame(width: 200, height: 50)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(.rect(cornerRadius: 40))
                }
                .transition(.opacity)
            }

            if !gameStart {
                Spacer()
            } else {
                VStack {
                    
                    // Information bar
                    HStack{
                        Text("Question: \(questionIndex) / \(selectedQuestionCount)")
                            .font(.title2)
                            .keyframeAnimator(
                                initialValue: 1.0,
                                trigger: questionIndex
                            ) { content, scale in
                                content.scaleEffect(scale)
                            } keyframes: { _ in
                                CubicKeyframe(1.2, duration: 0.3)
                                SpringKeyframe(1.0, duration: 0.6, spring: .bouncy)
                            }
                        Spacer()
                        Text("Score: \(score)")
                            .font(.title2)
                            .keyframeAnimator(
                                initialValue: 1.0,
                                trigger: score
                            ) { content, scale in
                                content.scaleEffect(scale)
                            } keyframes: { _ in
                                CubicKeyframe(1.2, duration: 0.3)
                                SpringKeyframe(1.0, duration: 0.6, spring: .bouncy)
                            }
                    }
                    .padding()
                    
                    
                    Spacer()
                    
                    // Question
                    VStack {
                        Text("\(selectedTable)  X  \(question.count != 0 ? question[questionIndex - 1] : 2)  =  ?")
                            .font(.largeTitle.bold())
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white.opacity(0.75))
                    .clipShape(.rect(cornerRadius: 20))
                    
                    Spacer()
                    Spacer()
                    
                    // user Input Text
                    Text(userAnswer.isEmpty ? "_" : userAnswer)
                        .font(.largeTitle.bold())
                    
                    // Input View
                    VStack(spacing: 10){
                        ForEach(numberRows.indices, id: \.self) { row in
                           HStack(spacing: 10) {
                               ForEach(numberRows[row], id: \.self) { number in
                                   if number.isEmpty {
                                       Button {
                                           guard !userAnswer.isEmpty else { return }

                                           if checkAnswer() {
                                               score += scoreStep
                                               correctQuestion += 1
                                           }
                                           nextQuestion()
                                       }
                                       label: {
                                           Image(systemName: "checkmark")
                                               .font(.title)
                                               .frame(maxWidth: .infinity)
                                               .frame(height: 70)
                                               .foregroundStyle(.white)
                                               .background(Color.orange.opacity(0.75))
                                               .clipShape(.rect(cornerRadius: 20))
                                       }
                                   } else {
                                       Button {
                                           inputNumber(number)
                                       }
                                       label: {
                                           Text("\(number)")
                                               .font(.title)
                                               .frame(maxWidth: .infinity)
                                               .frame(height: 70)
                                               .foregroundStyle(.white)
                                               .background(Color.orange.opacity(0.75))
                                               .clipShape(.rect(cornerRadius: 20))
                                       }
                                   }
                               }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white.opacity(0.50))
                    .clipShape(.rect(cornerRadius: 20))
                    
                    Spacer()
                    
                    Button {
                        goToMenu()
                    }
                    label: {
                        Text("Back to Menu")
                            .font(.title3.bold())
                            .foregroundStyle(.black)
                            .frame(width: 200, height: 40)
                            .background(Color.white)
                            .clipShape(.rect(cornerRadius: 20))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .backgroundStyle()
            }
        }
        .padding()
        .alert("Your Final Score is \(score)", isPresented: $showingAlert) {
            Button("Back to Menu") {
                goToMenu()
            }
            Button("Restart") {
                Start()
            }
        } message: {
            Text("You correct \(correctQuestion) Question!")
        }
        
    }
    
    func Start() {
        
        question.removeAll()
        for _ in 1...selectedQuestionCount {
            question.append(Int.random(in: 2...9))
        }
        
        userAnswer = ""
        questionIndex = 1
        score = 0
        correctQuestion = 0
        
        withAnimation(.easeInOut){
            gameStart = true
        }
    }
    
    func nextQuestion() {
        if questionIndex >= selectedQuestionCount {
            showingAlert = true
        } else {
            questionIndex += 1
            userAnswer = ""
        }
    }
    
    func goToMenu() {
        withAnimation(.easeInOut){
            gameStart = false
        }
        
        question.removeAll()
        score = 0
        questionIndex = 1
        userAnswer = ""
        correctQuestion = 0
    }
    
    func inputNumber(_ number: String) {
        if number == "⌫" {
            if !userAnswer.isEmpty {
                userAnswer.removeLast()
            }
        } else {
            guard !(userAnswer.isEmpty && number == "0") else {
                return
            }
            guard userAnswer.count < 3 else { return }
            userAnswer += number
        }
    }
    
    func checkAnswer() -> Bool {
        let answer = selectedTable * (question.isEmpty ? 2 : question[questionIndex-1])
        if Int(userAnswer) == answer{
            return true
        }
        return false
    }
}

#Preview {
    ContentView()
}
