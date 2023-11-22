//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by 수킴 on 2022/11/11.
//

import SwiftUI

struct ContentView: View {

    @State private var isQuestionAlert = true
    @State private var isQuitAlert = false
    @State private var gameCount = 10
    @State private var score = 0
    @State private var currentPick = ""
    @State private var questionPick = false
    
    private let rockPaperScissors = ["가위", "바위", "보"]
    
    var programPick: String {
        rockPaperScissors.randomElement() ?? ""
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            Button {
                gameCount -= 1
                currentPick = "가위"
                if (programPick == "보" && (questionPick == false)) || (programPick == "바위" && (questionPick == true)) {
                    score += 1
                } else {
                    if score > 0 {
                        score -= 1
                    }
                }
                
                isQuestionAlert = (gameCount == 0) ? false : true
                isQuitAlert = (gameCount == 0) ? true : false
            } label: {
                Text("가위")
            }
        
            Button {
                gameCount -= 1
                currentPick = "바위"
                if (programPick == "가위" && (questionPick == false)) || (programPick == "보" && (questionPick == true)) {
                    score += 1
                } else {
                    if score > 0 {
                        score -= 1
                    }
                }
                
                isQuestionAlert = (gameCount == 0) ? false : true
                isQuitAlert = (gameCount == 0) ? true : false
            } label: {
                Text("바위")
            }
        
            Button {
                gameCount -= 1
                currentPick = "보"
                if (programPick == "바위" && (questionPick == false)) || (programPick == "가위" && (questionPick == true)) {
                    score += 1
                } else {
                    if score > 0 {
                        score -= 1
                    }
                }
                
                isQuestionAlert = (gameCount == 0) ? false : true
                isQuitAlert = (gameCount == 0) ? true : false
            } label: {
                Text("보")
            }
            
            Spacer()
            
            LargeTitleView(text: "남은 기회는 \(gameCount)번 입니다.")
            LargeTitleView(text: "현재 점수는 \(score)점 입니다.")
        }
        .padding()
        
        .alert("승패를 정하세요", isPresented: $isQuestionAlert) {
            Button("승") {
                questionPick = true
            }
            Button("패") {
                questionPick = false
            }
        } message: {
            Text("승을 누르면 이겨야 되고 패를 누르면 져야됩니다.")
        }
        
        .alert("게임이 종료되었습니다", isPresented: $isQuitAlert) {
            Button("다시 시작") {
                gameCount = 10
                score = 0
                isQuestionAlert = true
            }
        } message: {
            Text("총 점수는 \(score)점입니다.")
        }
    }
    
}

struct LargeTitleView: View {
    
    var text: String = ""
    
    var body: some View {
        Text("\(text)")
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
