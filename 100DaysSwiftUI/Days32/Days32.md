
애니메이션을 사용하면 사용자인터페이스를 더 보기 좋게 할 수 있고, 프로그램에서 진행되는 작업을 이해하는데 도움을 줄 수 있습니다.

**애니메이션을 적용하는 방법은 3가지가 있습니다.**

1.  암시적애니메이션(뷰에 수정자를 추가하는 방식)
2.  바인딩에 수정자를 추가하여 사용하는 방법
3.  명시적애니메이션(명시적으로 변경사항을 요청하는 방식)

# 1. implict animation(암시적 애니메이션)을 사용하는 방법

암시적애니메이션을 사용할 때 뷰에 animation수정자를 사용할 수 있습니다.

> 버튼을 클릭할 수록 커지는 예시

```swift
struct ContentView: View {
    
    @State private var animationAmount = 1.0
    
    var body: some View {
        // 암시적애니메이션
        Button("버튼") {
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
				.blur(radius: (animationAmount - 1) * 3)
        .animation(.default, value: animationAmount)
    }
}

```

-   scaleEffect 수정자를 사용하면 지정한 값의 크기로 설정됩니다. (1.0이라면 100% 비율)
-   animationAmount 값이 변경될 때마다 애니메이션을 적용합니다.

----------

# 2. 애니메이션을 커스텀하는 방법

animtation 수정자에 애니메이션타입을 제어할 수 있습니다.

-   [Animation](https://developer.apple.com/documentation/swiftui/animation) 타입
    
    -   default : 기본 애니메이션
    -   linear : 선형 애니메이션
    -   easing : easeIn, easeOut, easeInOut
    -   spring
    -   . . .
-   duration에 파라미터를 제공하면 지정한 시간동안 애니메이션이 작동합니다.
    
-   delay() 수정자를 사용하면 애니메이션이 시작하는 시간을 지연시킬 수 있습니다.
    
-   repeatForever() 수정자를 사용하면 연속적으로 애니메이션을 사용할 수 있고 autoreverses 파라미터를 통해 원래크기로 돌릴지 설정할 수 있습니다.
    
-   overlay()수정자를 사용하면 오버레이 중인 뷰와 동일한 크기 및 위치에서 새로운 뷰를 생성할 수 있습니다.
    

> 얇은 원이 퍼지는 예시

```swift
Button("overlay") {
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeInOut(duration: 1)
                    .repeatForever(autoreverses: false),
                    value: animationAmount)
        )
        .onAppear {
            animationAmount = 2
        }

```

----------

# 3. 애니메이션을 바인딩하는 방법

애니메이션수정자는 모든 SwiftUI 바인딩에 적용할 수 있고, 현재 값과 새 값사이에 애니메이션이 되도록 합니다.

⭐️ SwiftUI는 값이 변경되면 먼저 바인딩상태를 변경한 다음 변경되는 과정을 애니메이션을 적용하는 것입니다.

→ 즉, 값을 변경이 먼저 된 후 애니메이션이 동작합니다.

> Scale값을 지정하여 바인딩된 프로퍼티와 사용하는 예시

```swift
@State private var animationAmount = 1.0

VStack {
    Stepper("Scale 값 : \\(animationAmount.formatted(.number))", value: $animationAmount.animation(
        .easeInOut(duration: 1)
                .repeatCount(3, autoreverses: true)
    ), in: 1...10)
    
    Spacer()
    
    Button("버튼") {
        animationAmount += 1
    }
    .padding(40)
    .background(.red)
    .foregroundColor(.white)
    .clipShape(Circle())
    .scaleEffect(animationAmount)
}

```

----------

# 4. explication animation (명시적 애니메이션)을 사용하는 방법

특정 애니메이션이 발생하도록 명시적으로 요청하기 위해서는 withAnimation 클로저를 사용합니다.

withAnimation클로저 내부에 원하는 작업을 작성하면 모든 변경사항이 자동으로 애니메이션이 됩니다.

withAnimation은 애니메이션 매개변수를 지정할 수 있습니다.

> 360도 회전하는 명시적애니메이션 예시

```swift
@State private var animationAmount = 1.0

Button("명시적애니메이션") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 1, z: 1))

```

-   rotation3DEffect() 수정자는 뷰가 회전하는 방법을 결정할 수 있습니다. degress 각도, axis 축을 제공하여 회전량을 지정할 수 있습니다.
