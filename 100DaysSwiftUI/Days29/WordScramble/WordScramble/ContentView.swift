//
//  ContentView.swift
//  WordScramble
//
//  Created by 수킴 on 2022/11/16.
//

import SwiftUI

struct ContentView: View {
        
    let people = ["Finn", "Leia", "Luke", "Rey", "Rey"]

    var body: some View {
        
        // MARK: - List 생성 (정적)
        List {
            Text("Hello World")
            Text("Hello World")
            Text("Hello World")
        }
        
        // MARK: - ForEach를 활용 (동적)
        List {
            ForEach(0..<5) {
                Text("Dynamic row \($0)")
            }
        }
        
        // MARK: - ForEach활용하지 않은 경우 (동적)
        List(0..<5) {
            Text("Dynamic row \($0)")
        }

        // MARK: - 정적 및 동적 함께 활용
        List {
            // Section의 타이틀이 텍스트만 있는 경우 아래처럼
            Section("Section 1") {
                Text("Static row 1")
                Text("Static row 2")
            }

            Section("Section 2") {
                ForEach(0..<5) {
                    Text("Dynamic row \($0)")
                }
            }

            // Section의 타이틀이 여러개인 경우
            Section {
                Text("Static row 3")
                Text("Static row 4")
            } header: {
                Text("Section 3")
                Text("Section 3")
            }
        }
        .listStyle(.grouped)
        
        // MARK: - 배열데이터로 동적 List 구현
        List(people, id: \.self) {
            Text($0)
        }

        // MARK: - 번들에서 파일 읽기
        Button("start.txt 가져오기", action: bundleLoadingFile)
        
        // MARK: - 문자열 철자 확인
        Button("문자열 철자 확인", action: checkSpellWord)
    }
    
    func bundleLoadingFile() {
        print("시작")
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                print(fileContents)
            } else {
                print("content 에러")
            }
            
        } else {
            print("URL 에러")
        }
    }
    
    func checkSpellWord() {
        let word = "swift"
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        let allGood = misspelledRange.location == NSNotFound
        
        print(allGood)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
