
# 1. 매개변수의 기본값을 제공하는 방법

매개변수의 기본값을 지정하면 매개변수의 값을 지정하지 않은 경우, 기본값을 기본적으로 사용합니다.

> 기본값 사용 예시

```swift
func printTimesTables(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\\(i) x \\(number) is \\(i * number)")
    }
}

printTimesTables(for: 5, end: 20)
printTimesTables(for: 8)

```

# 2. 함수의 오류를 처리하는 방법

스위프트에서 오류를 처리하는 방법

1.  발생할 수 있는 오류를 작성합니다.
2.  오류가 발생하면 처리할 함수를 작성합니다.
3.  해당 함수를 호출하고 발생할 수 있는 오류를 처리합니다.

오류를 처리할 함수를 작성할 때 `throws` 키워드를 통해 오류가 발생할 수 있다고 표시를 할 수 있습니다.

오류가 발생했을 때 발생했다고 표시할 때 `throw` 키워드를 통해 전달합니다.

`do` ~ `try` ~ `catch` 문 : `do` 블록안에서 오류가 발생할 수 있는 함수 앞에 `try` 를 작성합니다. 오류가 발생하면 `catch` 에서 처리합니다.

⚠️ 애플에서는 발생하는 대부분의 오류는 사용자가 이해할 수 있는 메시지를 `localizedDeccription` 으로 제공합니다.
