
# 1. GuessTheFlag프로젝트 애니메이션 확장하기

1.  깃발을 터치하면 Y축으로 360도 회전하는 애니메이션을 추가합니다.
2.  다른 깃발 버튼의 불투명도를 25%로 fade-out합니다.

-   적용
    
    ```swift
    @State var animationAmount = 0.0
    @State private var tappedFlag = ""
    
    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            
                            withAnimation(.interpolatingSpring(stiffness: 10, damping: 100)) {
                                tappedFlag = countries[correctAnswer]
    														animationAmount += 360
                            }
                        } label: {
                            FlagImage(imageName: countries[number])
                        }
                        .opacity((countries[number] == tappedFlag) ? 1 : ("" == tappedFlag) ? 1 : 0.25)
                        .scaleEffect((countries[number] == tappedFlag) ? 1 : ("" == tappedFlag) ? 1 : 0.25)
                        .animation(.default, value: tappedFlag)
                        .rotation3DEffect(.degrees((countries[number] == tappedFlag) ? animationAmount : 0.0), axis: (x: 0, y: 1, z: 0))
                    }
    
    ```
    
    1.  정답인 깃발의 국기를 저장하면서 애니메이션을 지정합니다.
    2.  정답인 버튼은 opacity수정자로 불투명도를 1 나머지는 0.25로 지정합니다.
    3.  정답인 버튼은 rotation3DEffect수정자로 정답인 경우만 360도 회전을 지정합니다.
