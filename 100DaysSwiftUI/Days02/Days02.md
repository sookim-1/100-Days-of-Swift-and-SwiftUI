
# 1. Bool(부울)값을 사용하는 방법

Bool이란 참, 거짓을 저장할 수 있는 타입입니다.

부울은 true, false 둘 중 하나의 값만 가집니다.

`!` 라는 특수 연산자를 사용하여 반대의 값을 표시할 수 있습니다.

`toogle()` 를 사용하면 반대의 값으로 변환됩니다.

# 2. 문자열 결합 및 보간법

## 문자열 결합

`+` 연산자를 사용하면 문자열들을 결합할 수 있습니다.

하지만 효과적인 방법은 아닙니다.

-   ex.) 예를 들어, 아래 결합을 통해 `"12345"` 를 만든 다고 하는 경우, `"12"` 를 만든 후, `"123"` 이런 방식으로 임시문자열을 만들면서 순서대로 결합하기 때문에 상당히 낭비적입니다.
    
    ```swift
    let luggageCode = "1" + "2" + "3" + "4" + "5"
    
    ```
    

## 문자열 보간법(String Interpolation)

문자열 안에 `\\` 를 쓰고 괄호안에 변수나 상수의 이름을 넣으면 해당 데이터값이 표시됩니다. 또한, 문자열 보간법 내부에는 연산식을 넣을 수도 있습니다.

```swift
let age = 20
let message = "I'm \\(age) years old."

```

----------

Swift5.0 부터는 문자열보간법에 확장을 할 수 있도록 변경되었습니다.

-   [고급] - [Swift 5.0의 문자열 보간법](https://www.hackingwithswift.com/articles/178/super-powered-string-interpolation-in-swift-5-0)

### 문자열 보간법 정수를 영어로 변환하는 방법

```swift
// 정수를 영어로 변환할 수 있습니다.
extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: Int) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut

        if let result = formatter.string(from: value as NSNumber) {
            appendLiteral(result)
        }
    }
}

```

### 문자열 보간법 날짜 형식 조정하는 방법

```swift
// 날짜 출력 형식 변환할 수 잇습니다.
extension String.StringInterpolation {
	mutating func appendInterpolation(_ value: Date) {
	    let formatter = DateFormatter()
	    formatter.dateStyle = .full
	
	    let dateString = formatter.string(from: value)
	    appendLiteral(dateString)
	}
}

```
