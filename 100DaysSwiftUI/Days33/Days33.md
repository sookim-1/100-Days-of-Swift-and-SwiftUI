
# 1. 애니메이션 스택을 다루는 방법

이전에 SwiftUI에서 뷰를 다룰 때 수정자의 순서가 중요한 개념을 이해했었습니다.

암시적애니메이션을 사용할 때 뷰에 수정자를 추가하는 방식으로 사용하므로 원하는 수정자마다 애니메이션을 적용할지 말지에 대한 처리를 할 수 있습니다.

> 색상애니메이션 비활성화, 모양 변경애니메이션 활성화 하는 예시

```swift
struct ContentView: View {
    
    @State private var enabled = false
    
    var body: some View {
        Button("버튼") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .blue : .red)
        .animation(nil, value: enabled)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
    }
    
}

```

-   색상을 변경하는 애니메이션은 nil로 비활성화합니다.
-   모양을 변경하는 clipShape수정자는 스프링애니메이션을 활성화합니다.

----------

# 2. Gesture animation(제스처 애니메이션)

SwiftUI는 모든 뷰에 제스처를 추가할 수 있고 제스처의 효과도 애니메이션화할 수 있습니다.

> 드래그 제스처로 드래그를 종료할 때 애니메이션처리 예시

```swift
// MARK: - 암시적 애니메이션 사용 (드래그 하는 경우 끝난 경우 모두 적용)
LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in
                        dragAmount = .zero
                    }
            )
            .animation(.spring(), value: dragAmount)

// MARK: - 명시적 애니메이션 사용 (드래그 끝난 경우만 적용)
LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            dragAmount = .zero
                        }
                    }
            )

```

----------

# 3. SwiftUI에서 뷰 Hidden처리하는 방법

UIKit의 뷰의 프로퍼티 중 isHidden값과 유사하도록 뷰를 특정 조건에서만 표시하고 숨기고 싶은 경우 부울값을 활용하여 특정 조건에서만 뷰를 생성하도록 할 수 있습니다.

> 애니메이션과 함께 뷰를 표시하고 숨기는 예시

```swift
@State private var isShowingRed = false

VStack {
    Button("버튼") {
        withAnimation() {
            isShowingRed.toggle()
        }
    }
    
    if isShowingRed {
        Rectangle()
            .fill(.red)
            .frame(width: 200, height: 200)
            .transition(.asymmetric(insertion: .scale, removal: .opacity))
    }
}

```

-   VStack을 사용하여 뷰를 표시하고 숨길 수 있습니다.

> 기존 뷰를 제거한 후 대체하는 예시

```swift
@State private var isShowingRed = false

ZStack {
    Rectangle()
        .fill(.blue)
        .frame(width: 200, height: 200)

    if isShowingRed {
        Rectangle()
            .fill(.red)
            .frame(width: 200, height: 200)
            .transition(.pivot)
    }
}
.onTapGesture {
    withAnimation {
        isShowingRed.toggle()
    }
}

```

-   ZStack을 사용하면 특정조건에 뷰를 가릴 수 있어 대체할 수 있습니다.
