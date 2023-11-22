
SwiftUI의 기본 구성요소는 View와 Modifier로 구성되었습니다.

# 1. SwiftUI가 View를 구조체로 사용하는 이유

UIKit 또는 AppKit은 View를 클래스로 사용합니다. 반면, SwiftUI는 View를 구조체로 사용합니다.

(1) 성능의 차이 : 구조체는 클래스보다 더 단순하고, 빠르기 때문에 구조체를 사용합니다.

-   UIKit의 모든 View는 배경색, constraints, 레이어 등등 많은 속성과 메서드를 가진 UIView클래스의 하위클래스이기 때문에 상속되어서 모든 것을 가지고 있어야합니다.
-   SwiftUI의 모든 View는 구조체이기 때문에 상속되지 않아 필요한 속성과 메서드만을 가지게 됩니다.

(2) 상태(State)를 분리하는 것 : 상태에 따라 UI를 업데이트 시켜줘야 합니다.

-   UIKit은 클래스이기 때문에 상태가 변경될 때, 값을 자유롭게 변경할 수 있으므로 코드가 복잡해집니다.
-   SwiftUI는 상태가 변경될 때, 시간이 지남에 따라 변경되지 않는 뷰를 생성하는 방식입니다. 데이터를 UI로 변환하고 구조체는 값을 변경시킬 때 mutate(@State)를 사용해야함으로써 변경되지 않는 것을 보장합니다.

<aside> 💡 즉, 상태가 변경될 때, UI를 변경시키는 경우, UIKit은 클래스이므로 값을 자유롭게 변경하고 SwiftUI는 구조체이므로 변경되지 않는 뷰를 새로 생성합니다.

</aside>

# 2. SwiftUI의 View는 mainView가 없습니다.

SwiftUI에서는 View뒤에는 아무것도 없다고 생각해야 합니다.

-   하지만, 적어도 ContentView뒤에 UIHostingController가 있습니다. UIHostingController는 UIKit과 SwiftUI를 연결시켜주는 것입니다. (즉, UIKit을 사용하고 싶은 경우에만 사용합니다.)
    
   

> 텍스트뷰 배경 지정 예시

```swift
// 텍스트뷰의 뒤에는 뒤에는 아무것도 없기 때문에 자체 뷰의 배경색만 변경됩니다. 
struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .background(.red)
    }
}

// 텍스트뷰의 크기를 지정해서 변경시켜야합니다.
struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
						.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.red)
    }
}


```

# 3. Modifier(수정자)의 순서가 중요한 이유

수정자를 적용할 때 기존의 존재하는 뷰를 수정하는 것이 아닌 변경된 사항을 적용한 뷰를 새로 생성합니다. (즉, 뷰들은 적용한 프로퍼티만을 가지고 있습니다.)

-   버튼 배경지정 순서 잘못된 예시
    
    ```swift
    struct ContentView: View {
        var body: some View {
            Button("Hello, world!") {
                // do nothing
            }
            .background(.red).     // 이 시점에 배경이 빨간 버튼 구조체 반환
            .frame(width: 200, height: 200) // 이 시점에 버튼 프레임을 200x200으로 변환한 구조체 반환
            .background(.blue)     // 이 시점에 배경색 파란 버튼 구조체 반환
        }
    }
    
    ```
    
-   버튼 배경지정 순서 예시
    
    ```swift
    struct ContentView: View {
        var body: some View {
            Button("Hello, world!") {
                // do nothing
            }
            .frame(width: 200, height: 200)
            .background(.red)
        }
    }
    
    ```
    
    

`type(of:)` 메서드를 통해 특정 타입을 출력할 수 있습니다.

-   뷰를 수정할 때마다 SwiftUI는 다음과 같은 제네릭을 사용하여 수정자를 적용합니다.
    -   **`ModifiedContent<OurThing, OurModifier>`**
    -   즉, 여러 수정자를 적용하면 **`ModifiedContent<ModifiedContent<..`** 이런 식으로 적용됩니다.
    -   안쪽의 컨텐츠부터 읽어나가는 것이 읽기 편합니다.

# 4. SwiftUI에서 View타입은 some View로 사용하는 이유

13회차 ReadMe참고 - some(불투명한 반환타입)

some View란 View프로토콜을 준수하지만 불투명한 하나의 객체라는 것을 의미합니다. (컴파일러는 반환타입을 알고 있습니다.)

(1) 성능에 중요합니다. - SwiftUI는 우리가 보여주는 뷰를 보고 그것들이 어떻게 변하는지 이해할 수 있어야 UI를 올바르게 업데이트할 수 있습니다.

-   만약 이러한 추가정보들이 없다면 변경사항을 정확히 파악하는데 느릴 것입니다.

(2) SwiftUI의 빌드방식을 고려하기 때문입니다.


-   View프로토콜 선언을 보면 associated type이 있는데 이것은 body내부의 타입에 따라 body의 타입을 지정하겠다는 의미입니다.
    
-   VStack이나 수정자를 여러개 사용한 경우 타입을 알지 않아도 내부적으로 처리가 가능하기 떄문에 편리합니다.
    
    -   팁 : VStack의 내부 뷰들은 TupleView로 만들어 파악합니다. 따라서 10개이상의 하위뷰를 가질 수 없는 것입니다. → ViewBuilder어노테이션 확장하면 최대20개로 가능합니다.
-   @ViewBuilder 어노테이션을 통해 TupleViewContainer 중 하나에 여러뷰를 자동으로 감싸서 하나의 TupleView로 결합됩니다.
    

# 5. Conditional modifiers(조건부 수정자)

SwiftUI에서 특정 조건과 수정자를 함께 사용하는 경우 삼항조건연산자를 사용하면 편리합니다.

만약 if문를 사용하면 SwiftUI에서는 더 많은 작업을 합니다. 조건이 변경될 때 기존의 뷰를 제거하고 다시 다른 구조체를 생성하므로 비효율 적입니다. (하지만, if문의 사용이 불가피한 경우는 사용해야합니다.)

> if문을 사용하여 버튼의 배경색 변경하는 예시

```swift
struct ContentView: View {
    @State private var useRedText = false

		var body: some View {
		    if useRedText {
		        Button("Hello World") {
		            useRedText.toggle()
		        }
		        .foregroundColor(.red)
		    } else {
		        Button("Hello World") {
		            useRedText.toggle()
		        }
		        .foregroundColor(.blue)
		    }
		}
}

```

> 삼항조건연산자를 사용하여 버튼의 배경색 변경하는 예시

```swift
struct ContentView: View {
    @State private var useRedText = false

    var body: some View {
        Button("Hello World") {
            useRedText.toggle()            
        }
        .foregroundColor(useRedText ? .red : .blue)
    }
}

```

# 6. Environment modifiers(환경 수정자)

환경수정자란? 많은 수정자를 컨테이너에 적용할 수 있으므로 동일한 수정자를 동시에 많은 뷰에 적용할 수 있습니다.

하위 뷰중 동일한 수정자를 재정의하는 경우 하위버전이 우선으로 동작합니다.

> 환경수정자와 하위 뷰 수정자 재정의 예시

```swift
VStack {
    Text("Gryffindor")
        .font(.largeTitle)
    Text("Hufflepuff")
    Text("Ravenclaw")
    Text("Slytherin")
}
.font(.title)

```

# 7. 프로퍼티를 사용하여 뷰 계층 구조 쉽게 사용하는 방법

SwiftUI에서 복잡한 뷰 계층 구조를 더 쉽게 사용할 수 있도록 하는 많은 방법이 있으며 한 가지 옵션은 속성을 사용하는 것입니다. 뷰를 자신의 뷰 프로퍼티로 만든 다음 레이아웃 내에서 해당 속성을 사용하는 것입니다.

-   장점
    1.  body 내부 코드의 가독성을 향상시킵니다.
    2.  반복작업을 줄일 수 있습니다.

🚨 객체 내에서 저장프로퍼티가 다른 저장프로퍼티를 참조하는 것은 불가능하기 때문에 @State프로퍼티와는 함께 사용할 수 없습니다.

하지만 연산프로퍼티를 사용하여 생성할 수 있습니다. 이런 경우 복잡한 뷰들을 작은 단위로 나눌 수 있어 좋지만, 자동으로 @ViewBuilder 어노테이션을 적용시키지 않기 때문에 여러개의 뷰를 보내고 싶은 경우 3가지 옵션을 사용할 수 있습니다.

1.  스택에 배치할 수 있습니다.
2.  Group, Section을 통해 배치할 수 있습니다.
3.  @ViewBuilder 어노테이션을 추가할 수 있습니다. (가장 권장하는 방법)

> 뷰 계층 구조를 위해 저장프로퍼티로 사용하는 예시

```swift
struct ContentView: View {
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")

    var body: some View {
        VStack {
				    motto1
				        .foregroundColor(.red)
				    motto2
				        .foregroundColor(.blue)
				}
    }
}

```

# 8. SwiftUI에서 뷰를 나누는 방법 (View Composition)

SwiftUI를 사용하면 성능에 큰 영향을 미치지 않으면서 복잡한 뷰를 더 작은 뷰로 나눌 수 있습니다.

> 뷰를 나누는 예시

```swift

// 중복되는 View를 가진 ContentView
struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("First")
                .font(.largeTitle)
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .clipShape(Capsule())

            Text("Second")
                .font(.largeTitle)
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .clipShape(Capsule())
        }
    }
}

// 텍스트값만 다르기 때문에 중복제거하여 CapsuleText 구조체 생성
struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}

// ContentView에서 사용 
struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
						CapsuleText(text: "First")
				        .foregroundColor(.white)
				    CapsuleText(text: "Second")
				        .foregroundColor(.yellow)
        }
    }
}

```

# 9. Custom modifiers (커스텀 수정자)

SwiftUI는 다양한 내장된 수정자를 제공하지만 직접 만드는 것도 가능합니다.

-   커스텀 수정자를 만드는 방법
    -   `Viewmodifier` 프로토콜을 준수하는 새로운 구조체를 작성합니다.
        -   some View를 반환하는 body 메서드를 작성해야 합니다.

생성한 수정자는 modifier()수정자와 함께 사용합니다.

View를 extension과 사용하면 한번 더 래핑하여 편리하게 사용할 수 있습니다.

> 커스텀 수정자와 extension활용 예시

```swift
struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

Color.blue
    .frame(width: 300, height: 200)
    .watermarked(with: "Swift")

```

🤔 extension 추가하는것과 커스텀수정자의 차이 ? 커스텀 수정자는 자신의 저장프로퍼티를 가질 수 있지만 View extension에서는 불가능합니다.

# 10. Custom containers (커스텀 컨테이너)

> 고정 그리드의 원하는 수의 뷰를 생성하는 커스텀 타입 예시

```swift
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \\.self) { row in
                HStack {
                    ForEach(0..<columns, id: \\.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

```

-   Content는 Generic을 사용하여 View프로토콜을 준수하는 모든 종류의 컨텐츠를 제공합니다.

# 참고링크

-   UIView의 프로퍼티와 메서드 (공식문서) - [](https://developer.apple.com/documentation/uikit/uiview)[https://developer.apple.com/documentation/uikit/uiview](https://developer.apple.com/documentation/uikit/uiview)
-   VStack 최대 제한 (스택오버플로우) - [](https://stackoverflow.com/questions/58397964/are-there-maximum-limits-to-vstack)[https://stackoverflow.com/questions/58397964/are-there-maximum-limits-to-vstack](https://stackoverflow.com/questions/58397964/are-there-maximum-limits-to-vstack)
