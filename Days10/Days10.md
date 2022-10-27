
# 1. 구조체를 사용하는 방법

스위프트는 여러 자료형들을 하나의 자료형으로 생성할 수 있는 방법 중 하나로 구조체를 사용할 수 있습니다.

<aside> 💡 즉, 구조체를 사용하면 고유한 변수 및 상수 고유한 기능으로 완성된 자료형을 만들 수 있습니다.

</aside>

> 구조체 특징

-   구조체에 속하는 변수와 상수를 프로퍼티(property)라고 합니다.
-   구조체에 속하는 함수를 메서드(method)라고 합니다.
-   구조체를 상수나 변수에 생성할 때 이를 인스턴스(Instance)라고 합니다.

구조체의 변수를 메서드에 값을 변경하는 경우 `mutating` 키워드를 메서드명 앞에 붙여야 합니다.

-   🤔 이유 : 만약, 구조체 인스턴스를 `let` 상수로 만드는 경우 모든 구조체의 데이터를 상수로 만들기 때문에 상수로 생성되는 경우 값이 변경되는 메서드의 호출을 막는다는것을 `mutating` 키워드로 방지하는 것입니다.

# 2. 연산프로퍼티를 사용하는 방법

구조체는 2가지 종류의 프로퍼티를 가질 수 있습니다.

1.  저장프로퍼티(stored property) : 구조체의 인스턴스 내부에 데이터를 보유하는 변수 및 상수
2.  연산프로퍼티(computed property) : 접근할 때마다 값을 동적으로 계산하는 변수 및 상수

연산프로퍼티를 활용하면 저장프로퍼티의 값을 직접 변경하지 않아도 되거나, 메서드를 작성하는 번거로움을 줄일 수 있습니다.

연산프로퍼티를 사용하기 위해서는 `getter` (읽기 전용), `setter` (쓰기 전용) 중 하나를 제공해야 합니다.

-   `getter` 만 사용하는 경우 생략가능합니다.
-   `setter` 를 활용하여 기존 저장프로퍼티의 값을 변경할 수 있습니다.
-   `newValue` 키워드를 통해 프로퍼티에 할당하려고 했던 값을 전달합니다.

> get set 예시

```swift
struct Student {
    let name: String
    var age: Int
    
    var futureAge: Int {
        get {
            return age + 10
        }
    
        set {
            print("10년이 지났다.")
            age = newValue
        }
    }
}

var chulsu = Student(name: "chulsu", age: 10)

print("철수의 현재나이 : \\(chulsu.age)")
chulsu.futureAge = 20
print("철수의 현재나이 : \\(chulsu.age)")

// 출력값
철수의 현재나이 : 10
10년이 지났다.
철수의 현재나이 : 20

```

# 3. 프로퍼티 옵저버를 사용하는 방법

스위프트는 프로퍼티의 값이 변경될 때 실행되는 코드인 프로퍼티옵저버를 만들 수 있습니다.

-   `didSet` : 프로퍼티의 값이 변경되었을 때 실행되는 옵저버
-   `willSet` : 프로퍼티의 값이 변경되기 전에 실행되는 옵저버

`didSet` 을 사용할 때 직접 프로퍼티명을 사용해도 되지만 `oldValue` 키워드를 사용하면 코드블록 내부에서 상수를 자동으로 제공합니다.

`willSet` 을 사용할 때 직접 프로퍼티명을 사용해도 되지만 `newValue` 키워드를 사용하면 코드블록 내부에서 상수를 자동으로 제공합니다.

<aside> 💡 didSet의 oldValue는 willSet의 변경될 프로퍼티와 동일합니다.

</aside>

> didSet, willSet - oldValue, newValue 예시

```swift
struct App {
    var contacts = [String]() {
        willSet {
            print("<willSet> property: \\(contacts)")
            print("<willSet> New value: \\(newValue)")
        }

        didSet {
            print("<didSet> property: \\(contacts)")
            print("<didSet> Old value:  \\(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Xcode")

// 출력값
<willSet> property: []
<willSet> New value: ["Xcode"]
<didSet> property: ["Xcode"]
<didSet> Old value:  []

```

# 4. 커스텀 이니셜라이저(초기화)하는 방법

이니셜라이저(초기화)는 새로운 구조체의 인스턴스를 준비하도록 설계된 특수한 메서드입니다. 구조체는 기본적으로 내부의 프로퍼티를 기반으로 자동으로 초기화를 진행하지만, 직접 커스텀할 수 있습니다.

⚠️ 단, 구조체의 모든 프로퍼티는 초기화가 종료될 때까지 값을 가져야 합니다.

기본적으로 사용하는 구조체의 초기화는 값이 할당되지 않은 모든 프로퍼티에 인스턴스를 생성하면서 값을 저장하기 때문에 `memberwise initializer` (멤버별 초기화)라고 부릅니다.

> 커스텀 이니셜라이저 예시

```swift
struct RandomPlayer {
    let name: String
    let number: Int
    
    init(name: String) {
        self.name = name
        number = Int.random(in: 1...20)
    }
}

let randomPlayer = RandomPlayer(name: "faker")
print(randomPlayer)

```

-   `init` 키워드를 통해 초기화하는 메서드라고 명시합니다.
-   `self` 키워드를 통해 매개변수와 프로퍼티 간의 구별을 명시적으로 작성해야 합니다.
