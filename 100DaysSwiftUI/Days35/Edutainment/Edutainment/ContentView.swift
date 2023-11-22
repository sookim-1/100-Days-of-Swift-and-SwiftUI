//
//  ContentView.swift
//  Edutainment
//
//  Created by 수킴 on 2022/11/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectNumber: Int = 2
    @State private var selectQuestionCount: Int = 5
    @State private var correctAnswer: Int = 0
    @State private var score: Int = 0
    @State private var currentIndex: Int = 0
    @State private var randomQuestion: [Question] = []
    
    @State private var isGameActive: Bool = false
    @State private var isCorrectAlert: Bool = false
    @State private var isFailAlert: Bool = false
    
    @FocusState var userAnswerIsFocused: Bool
    
    let questionCountArray: [Int] = [5, 10, 20]
    
    var body: some View {
        NavigationView {
            Form {
                Section("⭐️ 숫자를 선택하세요") {
                    Stepper("\(selectNumber)", value: $selectNumber.animation(.default), in: 2...12)
                        .padding()
                }
                
                Section("⭐️질문수를 선택하세요") {
                    Picker("", selection: $selectQuestionCount) {
                        ForEach(questionCountArray, id: \.self) {
                            Text("\($0)개")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Button("게임 시작") {
                        isGameActive = true
                        
                        randomGetQuestion()
                    }
                }
                
                Section {
                    if isGameActive {
                        Text(randomQuestion[currentIndex].question)
                    }
                }
                
                Section {
                    if isGameActive {
                        TextField("정답: ", value: $correctAnswer, format: .number)
                            .keyboardType(.numberPad)
                            .focused($userAnswerIsFocused)
                    }
                }
                
                
                if isGameActive {
                    Button("제출") {
                        if randomQuestion[currentIndex].correct == correctAnswer {
                            isCorrectAlert = true
                        } else {
                            isFailAlert = true
                        }
                    }
                }            }
            .navigationTitle("Edutainment")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("확인") {
                        userAnswerIsFocused = false
                    }
                }
            }
            
            .alert("정답입니다!", isPresented: $isCorrectAlert) {
                Button("확인") {
                    isCorrectAlert = false
                    correctAnswer = 0
                    score += 1
                    
                    if randomQuestion.count - 1 > currentIndex {
                        currentIndex += 1
                    } else {
                        resetGame()
                    }
                }
            }
            
            .alert("오답입니다!", isPresented: $isFailAlert) {
                Button("확인") {
                    isFailAlert = false
                    correctAnswer = 0
                    
                    if randomQuestion.count - 1 > currentIndex {
                        currentIndex += 1
                    } else {
                        resetGame()
                    }
                }
            }
        }
    }
    
    func randomGetQuestion() {
        for _ in 0..<selectQuestionCount {
            let randomNumber = Int.random(in: 1...9)
            randomQuestion.append(Question(question: "\(selectNumber) * \(randomNumber)", correct: selectNumber * randomNumber))
        }
    }
    
    func resetGame() {
        isGameActive = false
        randomQuestion.removeAll()
        currentIndex = 0
    }
    
}

struct Question: Hashable {
    let question: String
    let correct: Int
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
