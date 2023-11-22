
# 1. 프로젝트 설명

식당에서 식사를 한 후, 인원수와 남기고 싶은 팁, 음식비용을 기준으로 각 사람들이 결제해야하는 금액을 계산하는 앱입니다.

⚠️ Organization identifier와 project Name을 합친 것이 Bundle identifier입니다. - 단, 커스텀하여 입력할 수 도 있습니다.

----------

# 2. SwiftUI 기본 생성파일 분석하기

-   `WeSplitApp.swift` : 앱 실행을 위한 코드가 포함되어 있습니다. 앱이 실행되고 실행되는 동안 유지하고 싶은 경우 이 파일에 작성합니다.
-   `ContentView.swift` : 초기 프로젝트 생성시 UI를 포함하고 있는 파일입니다.
-   `Assets.xcassets` : 앱에서 사용하려는 에셋들을 관리하는 파일입니다.
-   `Preview Assets.xcassets` : preview에서 사용하려는 에셋들을 관리하는 파일입니다.

> ContentView.swift 예시

```swift
// 필요한 프레임워크 추가
import SwiftUI

// View프로토콜을 준수하는 ContentView구조체 생성
struct ContentView: View {
		// 연산 프로퍼티 body 선언 some View는 View프로토콜을 채택하는 어떤 것들을 반환한다는 의미
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
						// Text는 정적인 텍스트를 표시하고 필요에 따라 줄바꿈됩니다.
            Text("Hello, world!")
        }
        .padding() // 패딩이 된 VStack을 반환합니다.
    }
}

// Xcode에서만 사용할 수 있는 UI디자인 미리보기
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

```

-   화면에 그리기기 원하는 것들은 View프로토콜을 채택해야 합니다. 예를 들어, 텍스트, 버튼, 이미지, 커스텀 뷰등등
-   some 키워드는 뒤의 프로토콜을 채택하는 어떤 것들이 반환될 수 있다는 의미입니다. (some 키워드를 사용하지 않으면 매번 Stack추가할 때마다 자료형을 변경해줘야 하는 번거로움이 생깁니다.)
-   padding()은 수정자(modifier)라고 부르는 것인데 일반메서드와 차이점은 기존의 데이터와 요청한 추가 수정사항을 모두 포함한 새로운 뷰를 반환합니다.

----------

# 3. SwiftUI에서 Form을 사용하는 방법

SwiftUI에서 `Form` 을 통하여 뷰들을 양식을 정하여 대치를 할 수 있습니다.

Form `{ }` 안의 원하는 항목을 배치합니다.

⚠️ 주의 : 10개를 초과하여 항목을 배치하는 경우 즉, 11개 이상인 경우 SwiftUI에서는 부모 내부의 항목을 10개로 제한했기 때문에 에러가 발생합니다. 따라서 이런 경우 `Group` , `Section`을 사용하여 해결해야 합니다.

> Group, Section 사용 예시

```swift
// 에러 발생 - 11개 이상
Form {
    Text("Hello, world!")
    Text("Hello, world!")
    Text("Hello, world!")
    Text("Hello, world!")
    Text("Hello, world!")
    Text("Hello, world!")
    Text("Hello, world!")
    Text("Hello, world!")
    Text("Hello, world!")
    Text("Hello, world!")
    Text("Hello, world!")
}

// Group으로 분리
Form {
    Group {
        Text("Hello, world!")
        Text("Hello, world!")
        Text("Hello, world!")
        Text("Hello, world!")
        Text("Hello, world!")
        Text("Hello, world!")
    }

    Group {
        Text("Hello, world!")
        Text("Hello, world!")
        Text("Hello, world!")
        Text("Hello, world!")
        Text("Hello, world!")
    }
}

// Section으로 분리
Form {
    Section {
        Text("Hello, world!")
    }

    Section {
        Text("Hello, world!")
        Text("Hello, world!")
    }
}

```

-   Group은 UI를 변경하지 않으면서 SwiftUI의 10개의 자식뷰 제한을 해결할 수 있도록 합니다.
-   분할하여 다르게 구분을 하고 싶은 경우에는 Group대신에 Section을 사용해야 합니다.

----------

# 4. Navigation Bar를 추가하는 방법

iOS에서는 뷰들을 어느 곳에서든 배치가 가능하지만 systemUI나 디바이스 가장자리 같은 부분을 제외한 safe Area영역에 배치하는 것을 권장합니다.

Form을 통해 양식을 만들면 기본적으로 노치가 있는 디바이스에서 상단의 노치를 제외한 safeArea영역에 배치되지만 스크롤하게 되면 SystemU와 겹치게 될 수 있습니다. 따라서 navigation bar를 배치하여 해결할 수 있습니다.

`NavigationView` `{}` 안의 원하는 뷰를 배치합니다.

> NavigationView 사용 예시

```swift
var body: some View {
    NavigationView {
        Form {
            Section {
                Text("Hello, world!")
            }
        }
				.navigationTitle("SwiftUI")
        .navigationBarTitleDisplayMode(.inline)
    }
}

```

-   네비게이션바 제목 지정 : navigationTitle 수정자 추가
-   네비게이션바 표시 스타일 지정 : navigationBarTitleDisplayMode 수정자 추가

----------

# 5. 프로그램의 상태(State) 변경하는 방법

SwiftUI에서 뷰들은 상태의 함수라고도 합니다.

> 버튼을 클릭할 때 숫자 표시하는 잘못된 예시

```swift
struct ContentView: View {
    var tapCount = 0

    var body: some View {
        Button("Tap Count: \\(tapCount)") {
            tapCount += 1
        }
    }
}

```

-   ContentView는 구조체이므로 상수로 선언될 수 있기 때문에 tapCount를 변경하려면 mutating키워드를 사용해야 하지만, body는 연산프로퍼티이기 때문에 mutating을 허용하지 않습니다.
-   이러한 문제를 해결하기 위해 Swift는 프로퍼티래퍼(property wrapper)를 제공합니다.

> 버튼을 클릭할 때 숫자 표시하는 예시

```swift
struct ContentView: View {
    @State private var tapCount = 0

    var body: some View {
        Button("Tap Count: \\(tapCount)") {
            self.tapCount += 1
        }
    }
}

```

-   @State 프로퍼티래퍼를 통해 해당 변수의 값 수정가능한 위치에 SwiftUI에의해 별도로 저장하여 값이 변경될 수 있도록 설정할 수 있습니다.
-   SwiftUI에서 프로그램 상태를 저장하는 방법은 여러가지가 있지만 하나의 뷰에서 간단한 속성을 저장하는 경우 @State를 사용합니다.

🤔 그럼 ContentView를 클래스로 사용하지 않는 이유? SwiftUI는 구조체를 자주 없애고 재생성하기 때문에 성능을 위해서 구조체로 선언합니다.

----------

# 6. UI컨트롤과 상태 연결하는 방법

사용자가 어떠한 이벤트를 전달하는 경우 뷰 속성을 업데이트하는 방법

> 텍스트필드를 통해 사용자에게 입력받은 텍스트를 저장하는 방법 예시

```swift
struct ContentView: View {
    @State private var name = ""

    var body: some View {
        Form {
            TextField("Enter your name", text: $name)
            Text("Hello, world!")
        }
    }
}

```

-   텍스트필드는 프로그램에 저장된 값을 반영할 수 있어야지 사용할 수 있습니다. 사용자가 입력한 텍스트는 저장할 수 있어야 합니다.
-   사용자가 텍스트를 입력하는 상태에서 프로퍼티의 값도 같이 업데이트 해야하지만 스위프트는 프로퍼티의 값을 보여주는 것과 프로퍼티의 값을 변경하여 기록하는 거의 차이를 가집니다.

<aside> 💡 즉, 뷰에 있는 텍스트 내용이 name프로퍼티에도 같이 포함되어 있는지 확인을 한 후 실행가능합니다.

</aside>

↔️ 양방향 바인딩(two-way binding) : 프로퍼티의 값을 표시하면서, 변경 사항도 프로퍼티를 업데이트하도록 바인딩 하는 것입니다.

양방향 바인딩은 `$` 표시를 통해 선언합니다.

<aside> 💡 즉, 양방향바인딩은 프로퍼티값을 표시할 수도 있지만, 값도 저장할 수 있는 것

</aside>

----------

# 7. 반복문으로 View만드는 방법

반복적으로 View를 생성하고 싶은 경우 `ForEach` 를 사용하여 원하는 루프(반복)만큼 뷰를 생성할 수 있습니다.

⚠️ `ForEach` 를 사용하면 10개의 뷰 제한을 지키지 않아도 됩니다.

-   ForEach는 클로저를 전달하기 때문에 매개변수이름을 사용할 수 있습니다.

> Picker와 ForEach 같이 사용하는 예시

```swift
struct ContentView: View {
		// students배열은 상수이기 때문에 @State를 표시하지 않아도 됩니다.
    let students = ["Harry", "Hermione", "Ron"]
		// 변경될 수 있기 때문에 @State처리
    @State private var selectedStudent = "Harry"

    var body: some View {
        NavigationView {
            Form {
                Picker("Select your student", selection: $selectedStudent) {
                    // id 내부의 프로퍼티 students를 반복합니다.
										ForEach(students, id: \\.self) {
                        Text($0)
                    }
                }
            }
        }
    }
}

```

-   Picker를 사용하면 사용자가 옵션을 선택할 수 있는 뷰를 제공할 수 있습니다.
-   `id: \\.self` 구문 설명 : SwiftUI가 화면의 모든 뷰를 고유하게 식별할 수 있어야 하므로 상태가 변경될 때 감지할 수 있어야 하기 때문에 존재합니다.
