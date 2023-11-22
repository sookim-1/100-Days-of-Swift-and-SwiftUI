//
//  ContentView.swift
//  Drawing
//
//  Created by 수킴 on 2022/12/13.
//

import SwiftUI

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

// MARK: - Metal
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
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    @State private var colorCycle = 0.0

    var body: some View {
        /*
        // MARK: - CGAffineTransform
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                //.stroke(.red, lineWidth: 1)
                .fill(.red, style: FillStyle(eoFill: true))   // even-odd files 홀수짝수 채우기로 효과

            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])

            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
        
        
        // MARK: - ImagePaint
        
        // Color는 모두 사용 가능하지만
        Text("Hello World")
            .frame(width: 300, height: 300)
            .background(.red)
        
        Text("Hello World")
            .frame(width: 300, height: 300)
            .border(.red, width: 30)
        
        Text("Hello World")
            .frame(width: 300, height: 300)
            .background(Image(systemName: "circle.fill"))
        
        // Image는 ImagePaint를 사용
        Text("Hello World")
            .frame(width: 300, height: 300)
            .border(ImagePaint(image: Image(systemName: "circle.fill"), scale: 0.2), width: 30)
        
        Text("Hello World")
            .frame(width: 300, height: 300)
            .border(ImagePaint(image: Image(systemName: "circle.fill"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.2), width: 30)
        
        Capsule()
            .strokeBorder(ImagePaint(image: Image(systemName: "circle.fill"), scale: 0.1), lineWidth: 20)
            .frame(width: 300, height: 200)

         */
        
        // MARK: - Metal
        VStack {
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
