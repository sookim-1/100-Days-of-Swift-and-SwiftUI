
SwiftUI와 UIKit의 경고창 표시방법의 차이점

-   SwiftUI는 경고창을 먼저 생성한 후 조건이 트리거 될 때 경고창을 표시합니다. 뷰가 항상 프로그램 상태(State)를 반영하는 것이 중요하기 때문입니다.
-   UIKit은 경고창을 조건이 트리거 될 때 생성하여 표시합니다.

# 1. GuessTheFlag 프로젝트 확장하기

1.  사용자의 점수를 저장하는 프로퍼티를 추가하고, 정답 또는 오답인 경우 변경된 값을 경고창과 총 점수에 표시합니다.
2.  잘못된 국기를 선택한 경우 경고창에 잘못된 국기를 설명하는 경고창을 작성합니다.
3.  8번만 진행되도록 하고 최종 경고창을 표시한 후 다시시작 여부를 물어봅니다.
    -   남은기회를 모두 사용했을 경우 트리거될 조건과 경고창을 새로 생성합니다.
        
        ```swift
        // 프로퍼티
        @State private var isGameDone = false
        @State private var gameChance = 0
        
        // 경고창 생성
        .alert("게임 종료", isPresented: $isGameDone) {
                    Button("다시 시작", action: reset)
                } message: {
                    Text("게임을 다시 시작하겠습니까?")
                }
        
        func reset() {
            gameChance = 0
            score = 0
        }
        
        ```
