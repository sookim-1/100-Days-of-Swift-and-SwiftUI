
# 1. 네비게이션바 버튼 추가하기

> 툴바를 이용하여 버튼 추가하는 예시

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Text("Hello World!")
            .navigationTitle("제목")
            .toolbar {
                Button("버튼") {
                    print("클릭")
                }
            }
        }
    }
}

```

-   네비게이션바에 버튼을 추가하면 왼쪽에서 오른쪽으로 쓰는 언어는 오른쪽에 표시됩니다. 반대의 경우는 왼쪽에 표시됩니다.

----------

# 2. BetterRest 프로젝트 확장하기

1.  VStack양식을 Section으로 변경합니다.
    
    ```swift
    Section {
        DatePicker("시간을 선택하세요", selection: $wakeUp, displayedComponents: .hourAndMinute)
            .labelsHidden()
    } header: {
        Text("언제 일어나시겠습니까?")
                .font(.headline)
    }
    
    ```
    
2.  커피 잔 수를 Stepper에서 Picker로 동일한 값 범위를 표시하도록 변경합니다.
    
    ```swift
    Section {
        Picker("커피 섭취량", selection: $coffeeAmount) {
            ForEach(1..<21) {
                Text($0 == 1 ? "1잔" : "\\($0)잔")
            }
        }
        // Stepper(coffeeAmount == 1 ? "1잔" : "\\(coffeeAmount)잔", value: $coffeeAmount, in: 1...20)
    } header: {
        Text("하루 커피 섭취량")
            .font(.headline)
    }
    
    ```
    
3.  계산 버튼을 제거하고 권장 취침시간을 표시하도록 UI를 변경합니다.
    
    ```swift
    @State private var wakeUp = defaultWakeTime
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var sleepTime: String {
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
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "에러가 발생했습니다."
        }
    }
    
    Section {
        Text(sleepTime)
    } header: {
        Text("권장 수면시간")
            .font(.headline)
    }
    
    ```
