
# 1. ****CGAffineTransform, even-odd fills를 사용하여 Shape를 변환하는 방법****

****CGAffineTransform을 사용하면 path 또는 뷰를 회전(rotated), 축척(sclaed), sheared(절단)등의 효과를 만들 수 있습니다.****

-   ****CGAffineTransform는 각도(angle)를 도(degree)가 아니라 라디안(radian)으로 측정합니다.****

****even-odd fills을 사용하면 겹치는 shape들을 렌더링하는 방법을 제어할 수 있습니다.****

> 여러개의 회전 타원형 꽃잎 예시

```swift
struct Flower: Shape {
    // 각각의 꽃잎이 중앙으로부터 얼마나 떨어져있는지
    var petalOffset: Double = -20

    // 각각의 꽃잎의 너비
    var petalWidth: Double = 100

    func path(in rect: CGRect) -> Path {
        // 모든 꽃잎이 가지는 메인 경로
        var path = Path()

        // 16개 꽃잎을 만들기 위해 0부터 pi * 2(360도) 까지를 pi / 8로 나눈다.
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            print(number)
            // 반복문의 현재 값과 동일한 회전변환을 생성합니다.
            let rotation = CGAffineTransform(rotationAngle: number)

            // 회전에 그리기 공간의 너비와 높이의 절반에 해당하는 움직임을 추가하여 각 꽃잎이 모양의 중앙에 오도록 합니다.
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))

            // 고정된 y와 높이를 이용하여 새로운 경로생성 (타원)
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))

            // 변환을 타원에 적용해서 위치를 이동하도록 합니다.
            let rotatedPetal = originalPetal.applying(position)

            // 메인 경로에 추가
            path.addPath(rotatedPetal)
        }

        // 경로 반환
        return path
    }
}

struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0

    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .stroke(.red, lineWidth: 1)
                //.fill(.red, style: FillStyle(eoFill: true))   // even-odd files 홀수짝수 채우기로 효과

            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])

            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
    }
}

```

-   🚨 회전시킨 후 움직인 것과 움직이고 나서 회전하는 것은 같은 결과가 나오지 않습니다.
-   FillStyle의 짝수홀수 규칙을 통해 겹치는(overlay되는)부분에 색상을 지정해야 하는지에 대한 여부를 지정할 수 있습니다.
    -   짝수홀수 규칙옵션을 활성화하면 겹치는 부분은 색상이 채워지고 안겹치는 부분은 색상을 채우지 않습니다.

# 2. ImagePaint를 사용하여 border 그리고 fill 처리하는 방법

SwiftUI는 프로토콜에 크게 의존하는데, 도면 작업을 할 때 약간 혼란스러울 수 있습니다. 예를 들어, Color를 뷰로 사용할 수 있지만 채우기(fill), 스트로크(stroke) 및 테두리(border)에 사용되는 다른 프로토콜인 ShapeStyle도 준수합니다.

SwiftUI는 이미지가 렌더링되는 방식을 완전히 제어할 수 있는 방식으로 이미지를 감싸는 ImagePaint타입을 제공합니다.

ImagePaint를 사용하면 background, stroke, border, fill 여러곳에서 작업할 수 있습니다.

`ImagePaint(image: Image, sourceRect: CGRect, scale: CGFloat)`

-   image는 이미지를 제공합니다.
-   sourceRect : 지정된 도면의 소스로 사용할 직사각형
    -   기본값은 전체 이미지 (sourceRect를 사용하려면 상대 크기와 위치의 CGRect를 전달해야 합니다. 0은 시작 1은 종료를 의미합니다.)
-   scale : 해당 이미지에 대한 비율
    -   기본값은 1

> ImagePaint 예시 코드

```swift
Text("Hello World")
    .frame(width: 300, height: 300)
    .border(ImagePaint(image: Image(systemName: "circle.fill"), scale: 0.2), width: 30)

Text("Hello World")
    .frame(width: 300, height: 300)
    .border(ImagePaint(image: Image(systemName: "circle.fill"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.2), width: 30)

Capsule()
    .strokeBorder(ImagePaint(image: Image(systemName: "circle.fill"), scale: 0.1), lineWidth: 20)
    .frame(width: 300, height: 200)

```

# 3. drawingGroup()을 사용하여 Metal 렌더링 사용하는 방법

SwiftUI는 기본적으로 렌더링에 Core Animation을 사용하여 즉시 사용 가능한 뛰어난 성능을 제공합니다. 그러나 복잡한 렌더링의 경우 코드가 느려지기 시작할 수 있습니다. iOS장치가 초당 60프레임(FPS) 미만은 문제가 되지만 많은 iOS 장치가 이제 120fps로 렌더링되기 때문에 실제로는 더 높은 것을 목표로 해야 합니다.

> 그라디언트 원을 그리는 예시

```swift
struct ColorCyclingCircle: View {
    
    var amount = 0.0    // 색상의 주기
    var steps = 100     // 그려야 하는 원의 수

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }

    // 컬러를 얻는 메서드
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        // 0 ~ 1까지의 컬러만 사용
        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var colorCycle = 0.0

    var body: some View {
				// MARK: - Metal
        VStack {
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
        }
        
    }
}

```

-   drawingGroup()을 사용하면 SwiftUI에게 뷰의 내용을 화면에 표시하기 전에 off-screen이미지로 렌더링한 후 단일 렌더링으로 출력으로 화면에 표시한다고 전달합니다.(빠른 그래픽을 위해 GPU와 작업)
-   🚨 간단한 그리기에 사용하면 오히려 SwiftUI속도가 느려질 수 있어서 주의해야 합니다.
