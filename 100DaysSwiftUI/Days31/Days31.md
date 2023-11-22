
# 1. WordScramble 프로젝트 확장하기

1.  3글자보다 짧거나 시작단어는 허용을 하지 않도록 합니다.
    
    ```swift
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
    
    ```
    
2.  튤바버튼을 추가하여 게임을 재시작하도록 설정합니다.
    
    ```swift
    .toolbar(content: {
        Button("재시작", action: startGame)
    })
    
    // 초기화
    usedWords.removeAll()
    newWord = ""
    
    ```
    
3.  플레이어의 점수를 추적하고 표시할 수 있도록 텍스트를 배치합니다.
    
    -   새로운 단어 입력될 때마다 점수 증가하고 재시작할 때 초기화합니다.
