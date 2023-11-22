# 1. 프로젝트 설명

Drawing 프로젝트 : 우리는 사용자 지정 경로(custom path) 및 모양(shapes) 생성, 변경 사항 애니메이션, 성능 문제 해결 등을 포함하여 SwiftUI에서 그리기에 대해서 학습합니다.

SwiftUI는 애플의 프레임워크 중 CoreAnimation, Metal과 동일한 그리기 시스템을 사용합니다. CoreAnimation은 사용자 지정 경로(custom path) 및 모양(shapes) 생성, UI요소등을 그리는 부분을 담당하지만 복잡한 경우 Metal을 사용할 수 있습니다.

# 2. SwiftUI에서 사용자 지정 경로(custom path) 만드는 방법

SwiftUI는 custom shape를 그리기 위한 Path 타입을 제공합니다.

Color, Gradient, Shape처럼 Path도 그 자체로 뷰입니다.

> 삼각형 그리는 예시 코드

```swift
Path { path in
    path.move(to: CGPoint(x: 200, y: 100))
    path.addLine(to: CGPoint(x: 100, y: 300))
    path.addLine(to: CGPoint(x: 300, y: 300))
    path.addLine(to: CGPoint(x: 200, y: 100))
}
.fill(.blue)

// 마지막 선에 하위 경로를 닫도록 요청하는 코드
Path { path in
    path.move(to: CGPoint(x: 200, y: 100))
    path.addLine(to: CGPoint(x: 100, y: 300))
    path.addLine(to: CGPoint(x: 300, y: 300))
    path.addLine(to: CGPoint(x: 200, y: 100))
    path.closeSubpath() // 마지막 선을 닫아주도록 요청하여 모서리 부분 깔끔히 그려지도록 합니다.
}
.stroke(.blue, lineWidth: 10)

// StrokeStyle을 사용
Path { path in
    path.move(to: CGPoint(x: 200, y: 100))
    path.addLine(to: CGPoint(x: 100, y: 300))
    path.addLine(to: CGPoint(x: 300, y: 300))
    path.addLine(to: CGPoint(x: 200, y: 100))
}
.stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))    // StrokeStyle을 이용하여 둥근 느낌으로 사용합니다.


```

-   🚨 정확한 좌표를 작성하여도 화면크기마다 위치가 상대적으로 표시되기 때문에 모든 기기에서 사이즈를 확인하거나 GeometryReader를 사용하여 해결합니다.
-   클로저에서 경로를 매개변수로 전달받습니다.
-   CGPoint : CG는 CoreGraphics의 약자로 X,Y 좌표를 뜻합니다.
-   CGSize: CG는 CoreGraphics의 약자로 너비 및 높이를 뜻합니다.
-   CGRect : CG는 CoreGraphics의 약자로 직사가형 프레임을 뜻합니다.
-   StrokeStyle : lineWidth (테두리 너비) , linecap(모든 선이 연결 없이 끝날 때 어떻게 그려야 하는지), linejoin(모든 선이 뒤에 있는 선에 어떻게 연결되어야 하는지)

# 3. SwiftUI에서 Paths 와 Shapes의 차이점

SwiftUI에서는 paths와 shapes를 사용하여 커스텀그리기가 가능합니다.

-   path : 경로는 “여기서 시작하고 여기에 선을 그리고 다음 거기에 원을 추가합니다”와 같은 일련의 그리기 명령느낌 입니다. (모두 절대적인 좌표를 사용합니다.)
-   shape : 도형은 그것이 어디에 사용될 건지 또는 크기를 알지 못하지만, 주어진 직사각형 안에서 자신을 그려 넣도록 요청을 받습니다.

<aside> 💡 가장 큰 차이점은 재사용성의 차이입니다. Shape는 공간에서 유연성이 있고 매개변수도 허용가능하기 때문에 재사용성이 높습니다.

</aside>

shape도 마찬가지로 뷰입니다.

Shape프로토콜을 사용하여 구현합니다. func path(in rect: CGRect) -> Path를 구현해야 합니다.

shape를 구현하려면 rect 주어진 직사각형에서 경로를 생성하고 반환합니다. 따라서 절대좌표에 의존하지 않아도 됩니다.

> Shape를 사용하여 삼각형 그리는 예시 코드

```swift
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

Triangle()
    .fill(.red)
    .frame(width: 300, height: 300)

```

> Shape를 사용하여 호 그리는 예시 코드

```swift
struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)

        return path
    }
}

Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
    .stroke(.blue, lineWidth: 10)
    .frame(width: 300, height: 300)

// 위쪽을 0으로 두고 시계방향으로 만드는 방법
// Arc의 path부분을 변경합니다.
func path(in rect: CGRect) -> Path {
        
    let rotationAdjustment = Angle.degrees(90)
    let modifiedStart = startAngle - rotationAdjustment
    let modifiedEnd = endAngle - rotationAdjustment

    var path = Path()
    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

    return path
}

```



-   SwiftUI에서는 0도는 위쪽이 아니라 오른쪽이 기준입니다.



-   0도에서 90도로 이동할 때는 바로 이동하지 않고 반시계방향으로 이동합니다.

# 4. ****InsettableShape를 사용하여 strokeBorder()를 추가하는 방법****

특정한 크기 없이 shape를 만든다면 자동으로 이용 가능한 공간을 확장될 것 입니다. stroke는 선의 중심을 기준으로 테두리를 그리고 strokeBorder는 원의 내부를 기준으로 테두리를 그립니다.

strokeBorder수정자를 사용하기 위해서는 InsetableShape프로토콜을 준수해야 합니다.

InsetableShape : 다른 shape를 만들기 위해 내부를 축소할 수 있는 shape

-   inset(by: )를 구현해야 합니다. 해당 메서드는 inset값(stroke의 선 너비의 반)이 주어지면 새로운 종류의 insettable shape를 반환합니다.

> InsettableShape 예시

```swift
// MARK: - InsettableShape
struct InsettableArc: InsettableShape {
    var insetAmount = 0.0
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

```

-   InsettableShape은 Shape를 기반으로 하기 때문에 하나만 준수하면 됩니다.
-   inset메서드는 path메서드가 호출이 되지않아 크기를 모르기 때문에 기본값 0을 설정한 후 추가하는 방식으로 해결합니다.
