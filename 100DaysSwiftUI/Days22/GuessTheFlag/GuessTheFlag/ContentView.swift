//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by 수킴 on 2022/11/08.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var countries = ["에스토니아", "프랑스", "독일", "아일랜드", "이탈리아", "나이지리아", "모나코", "폴란드", "러시아", "스페인", "영국", "미국"].shuffled()
    
    @State private var showingMessage = ""
    
    @State private var isGameDone = false
    @State private var gameChance = 0
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
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
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("국가를 선택하세요")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("점수: \(score)\n남은 기회: \(8 - gameChance)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
                    .lineSpacing(20)

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("계속하기", action: askQuestion)
        } message: {
            Text("점수: \(score)")
        }
        
        .alert("게임 종료", isPresented: $isGameDone) {
            Button("다시 시작", action: reset)
        } message: {
            Text("게임을 다시 시작하겠습니까?")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "정답"
            score += 1
        } else {
            scoreTitle = "오답! 선택한 국기는 \(countries[number])입니다."
            
            if score > 0 {
                score -= 1
            }
        }

        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        gameChance += 1
        
        if gameChance >= 8 {
            isGameDone = true
        }
    }
    
    func reset() {
        gameChance = 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
