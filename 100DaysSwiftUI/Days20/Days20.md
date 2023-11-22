
# 1. GuessTheFlag 프로젝트 설명

-   세계의 국기를 보고 이름을 맞추는 프로젝트 입니다.

# 2. Stack을 사용하여 뷰들 정렬하는 방법

여러뷰를 조합하여 뷰를 반환하는 경우 Stack을 사용하여 반환하면 유용합니다.

-   HStack : 가로(수평)을 처리하는 스택
-   VStack : 세로(수직)을 처리하는 스택
-   ZStack : 깊이를 처리하는 스택

> Stack을 사용하지 않는 경우 예시

```swift
var body: some View {
    Text("Hello, world!")
    Text("This is another text view")
}

```

-   위의 body에 여러 뷰를 반환하므로 preview에서는 canvas가 두개가 생성되고 하나의 뷰에 보이지 않습니다.
    
    → 따라서 VStack을 사용하면 정렬하여 하나의 뷰로 반환할 수 있습니다.
    

----------

-   HStack, VStack의 spacing 파라미터로 뷰들 간의 간격을 지정할 수 있습니다.
    -   ZStack은 겹치기 때문에 간격을 지정할 수 없습니다.
-   Stack의 alignmnent 파라미터로 뷰들의 정렬기준을 지정할 수 있습니다.
-   SwiftUI의 다른 뷰들처럼 Stack은 최대 10개의 자식뷰를 가질 수 있고 추가하기 위해서는 Group, Section을 사용해야합니다.
-   기본적으로 HStack, VStack은 컨텐츠에 자동으로 맞춰지며, 사용 가능한 공간의 중앙에 정렬되는 것을 선호합니다.
    -   변경하려는 경우 Spacer()를 통해 한쪽으로 정렬할 수 있습니다.

# 3. SwiftUI에서 색상을 다루는 방법

SwiftUI에서는 색상을 렌더링하는 다양한 기능을 제공합니다.

Color 구조체를 이용하여 여러가지 내장 색상을 지원하고 Color.primary는 다크모드에서는 흰색, 라이트모드에서는 검정색이 됩니다. Color.secondary는 primary색상보다 좀 더 투명도가 있습니다.

> 텍스트 뒤에 배경 지정하는 예시

```swift
ZStack {
    Text("Your content")
}
.background(.red)

ZStack {
    Text("Your content")
        .background(.red)
}

```

-   위의 두가지 ZStack은 동일합니다.
-   즉, 텍스트뷰의 배경만 지정합니다.

> ZStack 전체 영역 배경을 지정하는 예시

```swift
ZStack {
    Color.red
					.frame(minWidth: 200, maxWidth: .infinity, maxHeight: 200)
    Text("Your content")
}
.ignoresSafeArea()

```

-   frame 수정자를 사용하면 특정 크기를 지정할 수 있습니다.
-   ignoresSafeArea 수정자를 사용하면 safeArea영역을 무시할 수 있습니다.

> 커스텀 컬러 지정하는 예시

```swift
Color(red: 1, green: 0.8, blue: 0)

```

-   빨간색, 녹색, 청색의 값을 0~1사이의 값으로 지정할 수 있습니다.

# 4. Gradient를다루는 방법

SwiftUI는 세가지 종류의 그라디언트를 제공합니다.

그라디언트는 여러가지 요소로 구성됩니다.

-   보여줄 색상(color)의 배열
-   크기(size)와 방향(direction)에 대한 정보
-   사용할 그라디언트의 타입

그라디언트의 타입

1.  `LinearGradient` : 직선으로 진행하는 그라디언트
2.  `RadialGradient` : 원 모양으로 바깥쪽으로 진행하는 그라디언트
3.  `AngularGradient` : 원뿔형으로 진행하는 그라디언트

> Gradient 예시

```swift

LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)

LinearGradient(gradient: Gradient(stops: [
        Gradient.Stop(color: .white, location: 0.45),
        Gradient.Stop(color: .black, location: 0.55),
    ]), startPoint: .top, endPoint: .bottom)

RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)

AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)

```

# 5. 버튼, 이미지를 다루는 방법

SwiftUI에서 버튼은 터치될 때 실행되는 클로저를 함께 작성할 수 있습니다. (action파라미터에 함수로도 제공이 가능합니다.)

-   role 파라미터로 버튼의 역할을 통해 모양을 지정할 수 있습니다.
-   buttonStyle 수정자를 통해 내장된 스타일을 지정할 수 있습니다.
-   label 파라미터로 커스텀 하여 버튼을 지정할 수 있습니다.

> 버튼 사용 예시

```swift
VStack {
    Button("Button 1") { }
        .buttonStyle(.bordered)
    Button("Button 2", role: .destructive) { }
        .buttonStyle(.bordered)
    Button("Button 3") { }
        .buttonStyle(.borderedProminent)
    Button("Button 4", role: .destructive) { }
        .buttonStyle(.borderedProminent)
    Button("Button 5") { }
        .buttonStyle(.borderedProminent)
        .tint(.mint)
    Button {
        print("Button was tapped")
    } label: {
        Text("Tap me!")
            .padding()
            .foregroundColor(.white)
            .background(.red)
    }
}

```

----------

SwiftUI에서 이미지를 처리하기 위해서 Image타입을 제공합니다.

-   `Image(”원하는 이미지명”)` : 에셋에 추가한 이미지를 로드합니다.
-   `Image(decorative: "원하는 이미지명")` : 동일한 이미지를 로드하지만 스크린 리더를 활성화한 사용자에게 읽어 주지 않습니다.
-   `Image(systemName: "원하는 이미지명")` : SFSymbol의 아이콘을 로드합니다.

💡 SFSymbol의 색상을 변경하고 싶은 경우 renderingMode 수정자를 통해 변경할 수 있습니다.

----------

SwiftUI에서 텍스트와 이미지를 동시에 지원하고 싶은 경우 Label 타입을 사용할 수 있습니다.

> Label 타입 사용 예시

```swift
Button {
    print("Edit button was tapped")
} label: {
    Label("Edit", systemImage: "pencil")
}

```

# 6. SwiftUI에서 Alert창 표시하는 방법

기본으로 제목을 설정하고 Alert창을 표시할지에 대한 여부를 양방향 바인딩을 합니다. 버튼을 클릭하면 false로 반환됩니다.

-   message 파라미터를 통해 본문을 제공할 수 있습니다.

> 하나의 버튼으로 구성된 Alert창 예시

```swift
struct ContentView: View {
    @State private var showingAlert = false

    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("One Button", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
				    Text("Please read this.")
				}
    }
}

```

> 2개의 버튼으로 구성된 Alert창 예시

```swift
struct ContentView: View {
    @State private var showingAlert = false

    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Two Button", isPresented: $showingAlert) {
				    Button("Delete", role: .destructive) { }
				    Button("Cancel", role: .cancel) { }
				}
    }
}

```
