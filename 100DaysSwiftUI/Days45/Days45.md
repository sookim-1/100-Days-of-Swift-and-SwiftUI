
# 1. SwiftUI의 특수효과(blur, blending) 처리하는 방법

SwiftUI는 실시간 블러 적용(real-time blurs), 블렌드 모드 적용(blend modes), 채도 조정(saturation adjustment)등 뷰 렌더링 방법을 특별하게 제어할 수 있습니다.

블렌드모드를 사용하면 하나의 뷰가 다른 뷰 위에 렌더링되는 방식을 제어할 수 있습니다.

-   기본모드는 normal이고 여러가지 모드가 존재합니다.

saturation은 0(색상 없음), 1(전체 색상) 사이의 값을 지정합니다.

> blendmode로 렌더링 되는 예시 코드

```swift
struct ContentView: View {
    @State private var amount = 0.0

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(.red)
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)

                Circle()
                    .fill(.green)
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)

                Circle()
                    .fill(.blue)
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)

            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}

```

-   기본적으로 Color.red, Color.green, Color.blue는 순수한 색상이 아니고 다크모드, 라이트모드에 잘 보이도록 설계된 적응형 색상이므로 순수한 색상을 얻고 싶으면 커스텀색상을 사용해야합니다.

# 2. ****animatableData로 간단한 Shape 애니메이션 처리하는 방법****

> animatableData을 사용하여 사다리꼴 애니메이션 적용 예시

```swift

struct Trapezoid: Shape {
    var insetAmount: Double

    var. animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))

        return path
   }
}

struct ContentView: View {
		@State private var insetAmount = 50.0
    
    var body: some View {
			Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
            .onTapGesture {
                withAnimation {
                    insetAmount = Double.random(in: 10...90)
                }
            }
    }
}

```

-   animatableData가 없으면 withAnimation을 해도 애니메이션은 적용되지 않습니다.
    -   insetAmount값이 임의의 값으로 설정되는 즉시 해당 값으로 바로 Trapezoid로 직접 전달하므로 애니메이션이 발생하는 중간값을 전달하지 않기 때문에 애니메이션이 적용되지않습니다.

# 3. ****AnimatablePair로 복잡한 Shape 애니메이션 처리하는 방법****

animatableData프로퍼티를 사용하여 Shape에 대한 변경사항을 애니메이션화할 수 있지만 여러개인 경우 AnimatablePair를 사용합니다.

> 행, 열 2가지 데이터의 변화에 따라 애니메이션 처리 예시

```swift
// MARK: - AnimatablePair
struct Checkerboard: Shape {
    var rows: Int
    var columns: Int

    // 정수는 불가능해서 Double로 변환하여 사용후 Int로 변환
    var animatableData: AnimatablePair<Double, Double> {
        get {
           AnimatablePair(Double(rows), Double(columns))
        }

        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // 각 행/열의 크기 파악
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)

        // 모든 행/열을 반복하여 사각형을 생성합니다.
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    // 이 사각형은 색상이 지정되어야 합니다. 여기에 직사각형을 추가합니다.
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)

                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }

        return path
    }
}

struct ContentView: View {
    
    @State private var rows = 4
    @State private var columns = 4
    
    var body: some View {
        Checkerboard(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    rows = 8
                    columns = 16
                }
            }
    }
}

```

-   예를 들어, 2개 이상인 경우 SwiftUI의 EdgeInsets 타입의 animatableData 프로퍼티는 `AnimatablePair<CGFloat, AnimatablePair<CGFloat, AnimatablePair<CGFloat, CGFloat>>>` 형식으로 되어 있습니다. newValue.second.second.first

# 4. SwiftUI로 ****spirograph를 만드는 방법****

spirograph란 원 안에 연필을 넣고 다른 원의 둘레를 돌면서 다양한 기하학적 무늬를 만들어내는 용어입니다.

> spirograph 예시

```swift
struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: Double
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
    }
    
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = Double(self.outerRadius)
        let innerRadius = Double(self.innerRadius)
        let distance = Double(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * amount
        
        var path = Path()
        
        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
            
            x += rect.width / 2
            y += rect.height / 2
            
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return path
    }
}

struct ContentView: View {
    
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var graphAmount = 1.0
    @State private var hue = 0.6
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: graphAmount)
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                .frame(width: 300, height: 300)
            
            Spacer()
            
            Group {
                Text("Inner radius: \\(Int(innerRadius))")
                Slider(value: $innerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Outer radius: \\(Int(outerRadius))")
                Slider(value: $outerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Distance: \\(Int(distance))")
                Slider(value: $distance, in: 1...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Amount: \\(graphAmount, format: .number.precision(.fractionLength(2)))")
                Slider(value: $graphAmount)
                    .padding([.horizontal, .bottom])
                
                Text("Color")
                Slider(value: $hue)
                    .padding(.horizontal)
            }
        }
    }
}

```

-   [hypotrochoids](%5B%3Chttps://en.wikipedia.org/wiki/Hypotrochoid%3E%5D(%3Chttps://en.wikipedia.org/wiki/Hypotrochoid%3E))를 참고
