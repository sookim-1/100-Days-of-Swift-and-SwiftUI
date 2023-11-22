
# 1. BetterRest 프로젝트 설명

-   사용자에게 정보를 입력받도록 하고 경고창으로 표시하는 프로젝트
-   CoreML이란 iPhone 내장된 기술은 이전에 학습한 데이터를 기반으로 새로운 데이터를 예측하는 코드를 작성하는 기술입니다.

커피를 마시는 사람들에게 3가지 질문을 하여 숙면을 취하도록 하는 프로젝트

1.  언제 일어나기를 원하는 지?
2.  원하는 수면시간은 몇 시간인지?
3.  하루에 몇 잔의 커피를 마시는지?

# 2. Stepper를 이용하여 숫자를 입력받는 방법

SwiftUI에서 숫자를 입력받는 방법 중 Stepper를 사용하면 정확한 숫자를 입력받을 수 있습니다.

> Stepper를 이용하여 숫자를 입력받는 예시

```swift
struct ContentView: View {
    @State private var sleepAmount = 8.0
    
    var body: some View {
        Stepper("\\(sleepAmount.formatted()) 시간", value: $sleepAmount, in: 4...12, step: 0.25)
    }
}

```

-   Stepper에 바인딩할 프로퍼티는 Double, Int 자료형 모두 가능합니다.
-   in 파라미터를 통해 범위를 제한할 수 있습니다. 제한을 하지 않으면 바인딩한 자료형이 Double이라면 Double값의 범위까지가 됩니다.
-   step 파라미터를 통해 단계마다 이동할 값을 지정할 수 있습니다.
-   formatted()를 통해 표시될 형식을 지정할 수 있습니다.

----------

# 3. DatePicker를 이용하여 날짜를 입력받는 방법

> DatePicker를 이용하여 날짜를 입력받는 예시

```swift
struct ContentView: View {
    @State private var wakeUp = Date.now
    
    var body: some View {
				DatePicker("날짜를 입력하세요", selection: $wakeUp, in: Date.now..., displayedComponents: .date)
    }
}

```

-   label에 원하는 제목문자열을 입력하고 Date타입을 바인딩합니다.
-   제목을 지우고 싶은 경우 VoiceOver를 활성화하기 위해 lablesHidden수정자를 사용해야 합니다.
-   displayedComponents 파라미터를 통해 사용자에게 표시되는 옵션의 종류를 결정할 수 있습니다.
    -   기본값은 일, 시간, 분을 표시합니다.
    -   .date를 사용하면 월, 일, 연도를 표시합니다.
    -   .hourAndMinute를 사용하면 시간, 분을 표시합니다.
-   in 파라미터를 통해 범위를 제한할 수 있습니다.

# 4. Date 다루는 방법

🚨 날짜를 다룰 때는 항상 정확하지 않습니다. 율리우스력 그레고리력 등등 같은 날짜 기준이어도 값이 다를 수 있습니다. 따라서 Apple의 프레임워크를 활용하면 문제를 해결할 수 있습니다.

Swift에서는 Date의 특정 부분을 읽거나 쓸수 있게 하기 위해 DateComponents자료형을 제공합니다.

> 현재 날짜에서 시간 더하는 방법 예시

```swift
// 현재날짜에서 내일까지 초단위 추가하기
let tomorrow = Date.now.addingTimeInterval(86400)

// 현재날짜부터 내일까지 범위
let range = Date.now...tomorrow

```

> DateComponents를 사용한 예시

```swift
// 오전 8시만을 표현하기 위한 예시
var components = DateComponents()
components.hour = 8
components.minute = 0

// 유효성 검증
let date = Calendar.current.date(from: components) ?? Date.now

```

# 5. CreateML로 모델 학습하는 방법

머신러닝을 구현하기 위해서는 첫번째로 모델을 훈련시킨 다움 다음 모델에 예측을 요청하는 방식입니다.

## CoreML Model 만드는 방법

1.  Xcode메뉴 → Open Developer Tool → Create ML
2.  NewDocuments → 템플릿 지정
3.  Training Data 파일 지정 → Target, Features, Algorithm 지정
4.  Train 실행 → Output에서 Get

# 참고링크

-   CreateML 설명 - [](https://www.youtube.com/watch?v=a905KIBw1hs)[https://www.youtube.com/watch?v=a905KIBw1hs](https://www.youtube.com/watch?v=a905KIBw1hs)
