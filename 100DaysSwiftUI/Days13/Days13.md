# 1. 프로토콜을 사용하는 방법

프로토콜을 사용하면 지원할 것으로 예상되는 데이터자료형이나 함수들을 정의하고 해당 프로토콜을 채택하면 규칙을 따르도록 합니다.

`protocol` 키워드를 사용하여 선언합니다.

선언한 프로토콜을 채택하고 싶은 경우 `:` 뒤에 프로토콜을 작성합니다.

부모클래스와 프로토콜을 동시에 채택하는 경우, 부모클래스를 먼저 상속받고 프로토콜을 채택해야합니다.

<aside> 💡 프로토콜을 사용하여 상속을 대체할 수 있습니다.

</aside>

# 2. 불투명한 반환값(Opaque Return Type)을 반환하는 방법

프로토콜을 반환타입으로 가질 경우, `some` 키워드를 사용하여 반환하면 컴파일 과정에서 발생하는 오류를 없앨 수 있습니다.

→ 즉, 컴파일러에게 명확한 타입을 가진 값만을 반환한다는 것을 알려주는 것입니다.

> 불투명한 반환값 예시

```swift
// Equatable을 채택한  어느 구조체가 반환될지를 알지 못합니다.
func getRandomNumber() -> Equatable {
    Int.random(in: 1...6)
}

// some을 사용하면 컴파일 단계를 넘어가여 반환하도록 변경할 수 있습니다.
func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

```

# 3. Extension 확장을 사용하는 방법

`extension` 키워드를 사용하면 직접 만든 자료형 및 애플의 자체 자료형에 기능을 추가할 수 있습니다.

> extension과 전역함수와의 차이점

1.  extension은 Xcode 자동완성으로 인해 쉽게 찾을 수 있습니다.
2.  전역함수는 추적하기 어렵지만 extension은 자료형에 따라 그룹화가 되기 때문에 전역함수보다 추적하기 수월합니다.
3.  extension은 기존 자료형의 내부 데이터에 대한 액세스 권한을 얻을 수 있습니다.

⚠️ extension에서 프로퍼티를 사용하는 경우 저장프로퍼티는 안되고 연산프로퍼티만 추가할 수 있습니다.

→ 왜냐하면, 저장프로퍼티를 추가하면 자료형타입의 실제 크기에 영향을 미치기 때문입니다.

# 4. 프로토콜과 extension을 같이 사용하는 방법

프로토콜과 extension을 활용하면 프로토콜의 메서드 구현을 직접 추가할 수 있습니다.

# 참고링크

-   some키워드 (WWDC19 - [](https://developer.apple.com/videos/play/wwdc2019/216/)[https://developer.apple.com/videos/play/wwdc2019/216/](https://developer.apple.com/videos/play/wwdc2019/216/))
