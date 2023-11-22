
# 1. WeSplit, GuessTheFlag, ViewsAndModifiers 프로젝트 복습 정리

-   Picker를 사용하는 방법
-   NavigationView를 생성하고 제목을 지정하는 방법
    -   status bar를 스크롤할때 겹치는 문제를 방지할 수 있습니다.
-   변하는 데이터를 저장하기 위해 @State를 사용하는 방법과 필요한 이유
    -   View가 구조체이기 때문입니다.
-   값을 읽고 저장하기 위해 양방향바인딩을 사용하는 방법 ($기호 사용)
-   ForEach를 사용하는 방법
-   HStack,VStack,ZStack을 사용하는 방법
-   뷰의 색상 및 그라디언트 설정하는 방법
-   뷰의 크기 프레임 지정하는 방법
-   버튼의 터치 이벤트처리 및 버튼 모양 만드는 방법
-   알림창(경고창)을 다루는 방법
-   수정자 순서가 중요한 이유
    -   수정자가 적용된 뷰를 반환해가기 때문입니다.
-   some View로 반환하는 이유
    -   성능의 문제와 타입을 매번 찾아서 지정하지 않아도 되기 때문입니다.
-   조건수정자를 사용하는 방법
-   뷰를 나누는 방법
-   커스텀 수정자, 커스텀 컨테이너를 만드는 방법

SwiftUI에서는 프로토콜, 프로토콜 확장, 프로토콜지향프로그래밍을 활용한 프레임워크입니다. 기존의 UI프레임워크(UIKit 등등)은 사용하지 않는 프로퍼티 및 메서드를 모두 상속받아야 했습니다. 하지만 SwiftUI는 필요한 프로퍼티와 메서드만을 사용하도록 설계되었습니다.

View프로토콜을 준수하기 위해서 해야하는 작업은 body 연산프로퍼티를 갖는 것입니다. body프로퍼티만 추가하면 SwiftUI는 레이아웃 및 렌더링을 수행하는 방법을 알고 있습니다.

----------

# 2. 구조체와 클래스의 차이

1.  클래스에는 멤버별이니셜라이저가 제공되지 않습니다. 구조체는 기본적으로 지원합니다.
2.  클래스는 상속을 사용할 수 있습니다. 구조체는 할 수 없습니다.
3.  클래스를 복사하면 두 복사본 모두 동일한 데이터를 가리킵니다.(Heap참조타입) 구조체의 복사본은 항상 고유합니다. (Stack값타입)
4.  클래스에는 초기화 해제자(deinitializer)가 있을 수 있습니다. 구조체는 없습니다.
5.  상수 클래스 내에서 변수프로퍼티를 변경할 수 있습니다. 상수 구조체 내에서 프로퍼티는 상수인지 변수인지에 관계없이 변경할 수 없습니다.

💡Tip : Objective-C언어에서는 모두 클래스를 사용했습니다.

----------

# 3. ForEach 배열과 함께 사용하는 방법

> ForEach 활용 예시

```swift
let number = ["0", "1", "2", "3"]

ForEach(0 ..< 4) { 
    Text("Row \\($0)")
}

ForEach(0..<number.count) {
    Text("Row \\(number[$0])")
}

// 배열을 직접 반복하는 방법
ForEach(number, id: \\.self) {
    Text("Row \\($0)")
}

```

----------

# 4. 바인딩하는 방법

값을 읽고 저장할 때 @State 변수를 만들고 $를 사용하여 양방향바인딩을 생성할 수 있지만, 만약, 현재 값을 계산하기 위한 로직을 실행하고 싶은 경우나, 값이 작성 될때 로직을 실행하고싶은경우 didSet프로퍼티옵저버를 활용하는 것보다 커스텀 바인딩을 활용할 수 있습니다.

> 기본적인 값을 읽고 저장하는 양방향 바인딩처럼 사용하는 예시

```swift
struct ContentView: View {
    @State private var selection = 0

    var body: some View {
        let binding = Binding(
            get: { selection },
            set: { selection = $0 }
        )

        return VStack {
            Picker("Select a number", selection: binding) {
                ForEach(0..<3) {
                    Text("Item \\($0)")
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

```

-   $기호를 사용하지 않아도 됩니다. 값을 읽고 저장하는(getter, setter) 부분을 변경할 수 있습니다.

> 값을 읽고 저장하는 부분을 커스텀하여 사용하는 예시

```swift
struct ContentView: View {
    @State private var agreedToTerms = false
    @State private var agreedToPrivacyPolicy = false
    @State private var agreedToEmails = false

    var body: some View {
        let agreedToAll = Binding<Bool>(
            get: {
                agreedToTerms && agreedToPrivacyPolicy && agreedToEmails
            },
            set: {
                agreedToTerms = $0
                agreedToPrivacyPolicy = $0
                agreedToEmails = $0
            }
        )

        return VStack {
            Toggle("Agree to terms", isOn: $agreedToTerms)
            Toggle("Agree to privacy policy", isOn: $agreedToPrivacyPolicy)
            Toggle("Agree to receive shipping emails", isOn: $agreedToEmails)
            Toggle("Agree to all", isOn: agreedToAll)
        }
    }
}

```

# 4. 가위바위보 프로젝트 만들기

프로젝트 설명

-   각 턴마다 무작위로 가위,바위,보 중 하나를 선택합니다.
-   사용자에게 승패를 묻는 메시지를 표시합니다.
-   버튼을 클릭하여 선택합니다.
-   이긴다면 점수를 얻고 지면 점수를 잃습니다.
-   10번의 기회가 끝나면 점수가 표시되고 게임이 종료됩니다.

> 가위바위보 예시

```swift
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
            
            LargeTitleView(text: "남은 기회는 \\(gameCount)번 입니다.")
            LargeTitleView(text: "현재 점수는 \\(score)점 입니다.")
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
            Text("총 점수는 \\(score)점입니다.")
        }
    }
    
}

struct LargeTitleView: View {
    
    var text: String = ""
    
    var body: some View {
        Text("\\(text)")
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
    
}

```
