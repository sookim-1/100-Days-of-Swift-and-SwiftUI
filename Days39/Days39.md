
# 1. MoonShot 프로젝트 설명

사용자는 우주프로그램의 임무들, NASA의 아폴로 우주프로그램에서 비행조종사들에 대해 학습하는 프로젝트

-   이미지를 적당한 크기로 배치하는 방법에 대해 학습합니다.
-   뷰들을 작은 단위로 나누는 방법에 대해 학습합니다.
-   연산프로퍼티를 활용하여 가독성을 향상시키는 방법에 대해 학습합니다.

----------

# 2. GeometryReader를 사용하여 화면에 맞게 이미지 리사이징을 하는 방법

SwiftUI에서 Image를 생성하면 컨텐츠의 크기에 따라 자동적으로 사이즈가 정해집니다. (예를 들어, 사진의 크기가 1000x500이라면 Image의 사이즈도 1000x500이 됩니다.)

GeometryReader를 사용하면 원하는 크기로 Image를 지정할 수 있습니다.

> 이미지 사이즈를 조절한 잘못된 예시

```swift
// frame을 사용하여 자르는 예시 
Image("Example")
    .frame(width: 300, height: 300)
		.clipped()

// 이미지의 비율이 맞지 않는 예시
Image("Example")
    .resizable()
    .frame(width: 300, height: 300)

// scaledToFill
Image("Example")
    .resizable()
    .scaledToFill()
    .frame(width: 300, height: 300)

// scaledToFit
Image("Example")
    .resizable()
    .scaledToFit()
    .frame(width: 300, height: 300)

```



-   Preview에서 Selectable 옵션키면 뷰 경계확인이 가능합니다.
-   frame을 이용하면 해당 크기만큼의 이미지뷰의 프레임이 설정되지만 이미지의 컨텐츠는 그대로입니다. cliped()를 사용하여 컨텐츠가 짤리는 것 뿐입니다.
-   resizable()을 사용하면 크기는 올바르게 조정되지만 왜곡되어 표시됩니다.
    -   scaledToFit()을 사용하면 뷰의 일부가 비어 있어도 비율을 최우선시 합니다.
    -   scaledToFill()을 사용하면 뷰의 빈 부분이 없도록 하는 것을 최우선시 합니다.

> GeometryReader를 사용한 예시

```swift
GeometryReader { geo in
    Image("aldrin")
        .resizable()
        .scaledToFit()
        .frame(width: geo.size.width * 0.8, height: 300)
}

// 중앙에 위치 시키기
GeometryReader { geo in
    Image("aldrin")
        .resizable()
        .scaledToFit()
        .frame(width: geo.size.width * 0.8)
        .frame(width: geo.size.width, height: geo.size.height)
}

```

GeometryReader뷰를 생성하면 GeometryProxy가 전달됩니다.

기본적으로 GeometryReader뷰는 레이아웃에서 사용 가능한 공간을 차지하도록 자동으로 확장된 다음 top-left 왼쪽 위 모서리에 정렬됩니다.

# 3. ScrollView를 사용하여 데이터 스크롤 하는 방법

List와 Form을 이용하여 데이터를 스크롤할 수 있지만 임의의 데이터를 스크롤 하는 경우 ScrollView를 사용할 수 있습니다.

ScrollView는 수직, 수평, 양방향으로 스크롤 할 수 있습니다. ScrollView 안에 뷰를 배치하면 사용자가 한쪽 가장자리에서 다른 쪽 가장자리로 스크롤할 수 있도록 해당 콘텐츠의 크기를 자동으로 파악합니다.

SwiftUI는 ScrollView안에 뷰를 추가하는 즉시 생성됩니다. 즉, 스크롤을 내려서 볼 때 시점이 아닌 뷰가 추가될 때 생성됩니다. LazyStack을 사용하여 해결할 수 있습니다. LazyStack은 필요에 따라 컨텐츠를 로드합니다. (실제로 표시될때 뷰를 생성합니다.)

LazyStack과 일반 Stack의 차이 중 하나는 레이아웃에서 차이점이 있습니다. LazyStack은 항상 레이아웃에서 사용 가능한 만큼의 공간을 차지하는 반면 일반 Stack은 필요한 만큼의 공간만 차지합니다.

> ScrollView 예시 코드

```swift
ScrollView {
    VStack(spacing: 10) {
        ForEach(0..<100) {
            CustomText("Item \\($0)")
                .font(.title)
        }
    }
    .frame(maxWidth: .infinity)
}

ScrollView(.horizontal) {
    LazyHStack(spacing: 10) {
        ForEach(0..<100) {
            CustomText("Item \\($0)")
                .font(.title)
        }
    }
}

```

# 4. NavigationLink를 사용하여 새로운 뷰로 전환하는 방법

SwiftUI에서 NavigationView는 뷰 상단에 네비게이션바를 표시하지만 새로운 뷰를 스택으로 푸시할 수 있습니다.

NavigationLink는 SwiftU의 모든 종류의 뷰에 적용할 수 있습니다. 클릭 될 대상을 지정하고 전환될 대상을 지정하면 됩니다.

**NavigationLink와 sheet의 차이점**

-   NavigationLink는 흐름을 타고 가는 뷰를 표시할 때 사용합니다.
-   sheet는 흐름에서 벗어나는 뷰를 표시할 때 사용합니다.

> NavigationLink 예시

```swift
NavigationView {
    NavigationLink {
        Text("Detail View")
    } label: {
        Text("Hello, world!")
            .padding()
    }
    .navigationTitle("SwiftUI")
}

```

# 5. hierarchical (계층적) Codable 데이터를 다루는 방법

JSON형식에서 계층적인 데이터를 갖는 경우 별도의 타입을 만들어서 처리합니다.

> JSON 계층 데이터 처리하는 예시

```swift
struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

Button("Decode JSON") {
    let input = """
    {
        "name": "Taylor Swift",
        "address": {
            "street": "555, Taylor Swift Avenue",
            "city": "Nashville"
        }
    }
    """

    let data = Data(input.utf8)
    let decoder = JSONDecoder()
    if let user = try? decoder.decode(User.self, from: data) {
        print(user.address.street)
    }
}


```

-   User라는 Codable 타입 내부의 Address 별도의 타입을 생성하여 처리합니다.

# 6. 스크롤되는 Grid에 뷰를 배치하는 방법

화면에 많은 데이터를 표시하기 위해서 LazyHGrid(수평 데이터를 표시), LazyVGrid(수직 데이터를 표시)를 사용할 수 있습니다.

Lazy가 붙은 이유는 SwiftUI가 필요할 때까지 포함된 뷰들의 로드를 지연하기 때문에 시스템리소스를 적게 사용하여 더 많은 데이터를 표시할 수 있습니다.

-   그리드를 생성하는 방법
    1.  원하는 행 또는 열을 정의합니다. (단 그리드 종류에 따라서 한가지만 정의합니다.)
        
        ```swift
        // MARK: - 레이아웃 고정
        let layout = [
            GridItem(.fixed(80)),
            GridItem(.fixed(80)),
            GridItem(.fixed(80))
        ]
        
        // MARK: - 최소, 최대 범위 지정
        let layout = [
            GridItem(.adaptive(minimum: 80, maximum: 120)),
        ]
        
        ```
        
    2.  ScrollView에 정의한 레이아웃을 사용하여 그리드를 배치합니다.
        
        ```swift
        // MARK: - 수직그리드
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(0..<1000) {
                    Text("Item \\($0)")
                }
            }
        }
        
        // MARK: - 수평그리드
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(0..<1000) {
                    Text("Item \\($0)")
                }
            }
        }
        
        ```
