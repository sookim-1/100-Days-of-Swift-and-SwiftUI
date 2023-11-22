
# 1. BetterRest, WordScramble, Animations 프로젝트 복습 정리

-   `Stepper`를 이용하여 사용자에게 숫자를 입력받을 수 있습니다.
-   `DatePicker`를 사용하여 날짜를 입력받고 `displayedComponents`파라미터로 날짜 및 시간을 처리할 수 있습니다.
-   Swift에서 날짜를 다룰 때, `Date`, `DateComponents`, `DateFormatter` 를 사용할 수 있습니다.
-   iOS에서 머신러닝을 구현하는 방법에 대해서 배웠습니다.
-   뷰가 보여질 때 `onAppear()` 를 사용합니다.
-   앱번들에서 파일을 읽기 위해서 Bundle 클래스에서 경로를 찾은 후 로딩합니다.
-   fatalError()를 사용하면 앱이 Crash 충돌합니다.
-   UITextChecker를 사용하면 스펠링(철자)를 확인할 수 있습니다.
-   암시적애니메이션은 animation() 수정자를 사용합니다.
-   애니메이션을 사용할 때 delay, repeat 등 설정할 수 있고, 애니메이션 방식도 지정할 수 있습니다.
-   바인딩과 함께 animtaion을 사용할 수 있습니다.
-   명시적애니메이션은 withAnimation()을 사용합니다.
-   여러 animation()수정자를 여러번 사용해서 처리할 수 있습니다.
-   DragGesture()와 함께 애니메이션을 지정했습니다.
-   transition을 이용하여 내장된 전환방식을 사용하거나 커스텀하여 사용했습니다.

----------

# 2. Edutainment 프로젝트 만들기

-   사용자는 연습할 구구단을 선택합니다.
    
    -   범위는 2~12까지 Button 또는 Stepper 사용합니다.
-   사용자는 5, 10, 20개 중에서 원하는 질문 수를 선택합니다.
    
-   설정한 옵션에 따라 질문을 무작위로 생성합니다.
    
-   점수를 표시하고 재시작을 유도합니다.
    
-   코드
    
    ```swift
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
                        Stepper("\\(selectNumber)", value: $selectNumber.animation(.default), in: 2...12)
                            .padding()
                    }
                    
                    Section("⭐️질문수를 선택하세요") {
                        Picker("", selection: $selectQuestionCount) {
                            ForEach(questionCountArray, id: \\.self) {
                                Text("\\($0)개")
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
                randomQuestion.append(Question(question: "\\(selectNumber) * \\(randomNumber)", correct: selectNumber * randomNumber))
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
    
    ```
