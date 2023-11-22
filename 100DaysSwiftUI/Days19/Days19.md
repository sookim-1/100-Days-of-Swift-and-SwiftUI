
# 1. Converter 프로젝트 만들기

프로젝트 설명

-   단위 변환을 처리하는 앱이고, 사용자는 입력 단위와 출력 단위를 선택한 다음 값을 입력하면 변환된 출력값을 표시합니다.

입력 단위는 총 4가지입니다.

1.  온도 변환 : 섭씨, 화씨, 켈빈
2.  길이 변환 : 미터, 킬로미터, 피트, 야드(마일)
3.  시간 변환 : 초, 분, 시간
4.  부피 변환 : 그램, 킬로그램, 온스, 파운드

세부단위는 세그먼트컨트롤로 표시합니다.

사용자는 텍스트필드로 숫자를 입력받습니다.

변환된 결과는 텍스트로 표시합니다.

# 2. Converter 프로젝트 구현하기

Swift에서는 [UnitLength](https://developer.apple.com/documentation/foundation/unitlength) 클래스를 제공합니다. 이를 이용해서 길이의 측정 단위를 사용할 수 있습니다.

[MeasurementFormatter](https://developer.apple.com/documentation/foundation/measurementformatter) : 단위 및 측정을 지역화된 표현을 제공하는 포맷터

> 1시간을 분단위로 측정값 변환하는 예시

```swift
let formatter: MeasurementFormatter
    
init() {
    formatter = MeasurementFormatter()
    formatter.unitOptions = .providedUnit 
    formatter.unitStyle = .long
}

var resultValue: String {
    let inputLength = Measurement(value: 1, unit: UnitDuration.hours)
    let outputLength = inputLength.converted(to: UnitDuration.minutes)
    return formatter.string(from: outputLength)
}

```

### Non-constant range: argument must be an integer literal 에러

`id`파라미터가 있는 이니셜라이저를 사용하면, `data`파라미터는 `Range<Int>`가 아닌 `Data`로 여기기 때문에 `id`를 설정해주면 경고창이 제거됩니다.

# 참고링크

-   단위 및 측정값을 변환하는 방법 - [](https://www.hackingwithswift.com/example-code/system/how-to-convert-units-using-unit-and-measurement)[https://www.hackingwithswift.com/example-code/system/how-to-convert-units-using-unit-and-measurement](https://www.hackingwithswift.com/example-code/system/how-to-convert-units-using-unit-and-measurement)
