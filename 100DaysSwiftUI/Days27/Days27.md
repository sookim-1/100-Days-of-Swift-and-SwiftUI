
# 1. CoreML로 머신러닝을 구현하는 방법

CreateML로 훈련된 모델이 있으면 입력으로 사용해야 하는 값을 전송한 후 반환되는 값을 읽으면 됩니다.

훈련된 모델을 Xcode프로젝트에 추가하면 Swift클래스가 자동으로 생성됩니다. 자동으로 생성된 클래스의 이름은 해당 모델명과 동일합니다.

> CoreML 구현 예시

```swift
do {
    let config = MLModelConfiguration()
    // 모델 인스턴스 생성
    let model = try SleepCalculator(configuration: config)

    // DatePicker로 가져온 시간 값
    let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
    let hour = (components.hour ?? 0) * 60 * 60
    let minute = (components.minute ?? 0) * 60

    // 모델의 파라미터로 입력값들 전달
    let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

    // 결과값 계산
    let sleepTime = wakeUp - prediction.actualSleep
} catch {
    print("에러발생")
}

```

-   prediction()을 통해 결과값을 확인합니다.
