//
//  ContentView.swift
//  WordScramble
//
//  Created by 수킴 on 2022/11/16.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("단어를 입력하세요!", text: $newWord)
                }
                .textInputAutocapitalization(.never)

                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button("재시작", action: startGame)
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            
            .alert(errorTitle, isPresented: $showingError) {
                Button("확인", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func addNewWord() {
        // 소문자로 변환 후 공백, 개행 제거
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // 3글자 이상 확인
        guard answer.count > 2 else {
            wordError(title: "", message: "3글자 이상입력하세요.")
            return
        }
        
        // 첫 단어 허용 확인
        guard answer.hasPrefix(rootWord.first?.lowercased() ?? "") == false else {
            wordError(title: "", message: "시작단어는 허용하지않습니다..")
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "이미 사용한 단어입니다.", message: "다른 단어를 입력하세요")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "입력할 수 없는 단어입니다.", message: "확인하세요 : '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "단어를 인식할 수 없습니다.", message: "철자를 확인하세요!")
            return
        }
        
        // 배열에 추가 후 초기화
        withAnimation {
            usedWords.insert(answer, at: 0) // append를 하면 맨 아래쪽부터 추가되므로 위부터 추가하도록 insert 사용
            score += 1
        }
        
        newWord = ""
        
    }
    
    func startGame() {
        // 1. 앱번들에서 start.txt 파일 URL 찾기
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. String 타입으로 start.txt 로드하기
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. 개행 기준으로 문자열배열 만들기
                let allWords = startWords.components(separatedBy: "\n")

                // 4. 해당 배열에서 무작위 요소 가져오기
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords.removeAll()
                newWord = ""
                score = 0
                
                return
            }
        }

        fatalError("start.txt 로드 불가")
    }
    
    // 이전에 사용한 단어인지 여부 판단
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    // 임의의 단어가 다른 임의의 단어의 문자로 만들 수 있는지 판단
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
    
    // 철자가 틀린 단어인지 판단
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
