//
//  ContentView.swift
//  Drawing
//
//  Created by 수킴 on 2022/12/13.
//

import SwiftUI

// MARK: - animatableData
struct Trapezoid: Shape {
    var insetAmount: Double
    
    var animatableData: Double {
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
    
    @State private var amount = 0.0
    @State private var insetAmount = 50.0
    
    @State private var rows = 4
    @State private var columns = 4
    
    
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var graphAmount = 1.0
    @State private var hue = 0.6
    
    var body: some View {
        /*
         // MARK: - BlendMode
         ZStack {
         Image(systemName: "globe")
         .resizable()
         .scaledToFit()
         
         Rectangle()
         .fill(.red)
         .blendMode(.multiply)
         // .blendMode(.screen)
         }
         .frame(width: 400, height: 500)
         .clipped()
         
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
         
         // MARK: - saturation, blur
         Image(systemName: "globe")
         .resizable()
         .scaledToFit()
         .frame(width: 200, height: 200)
         .saturation(amount)
         .blur(radius: (1 - amount) * 20)
         
         
         // MARK: - animatableData
         Trapezoid(insetAmount: insetAmount)
         .frame(width: 200, height: 100)
         .onTapGesture {
         withAnimation {
         insetAmount = Double.random(in: 10...90)
         }
         }
         
         // MARK: - AnimatablePair
         Checkerboard(rows: rows, columns: columns)
         .onTapGesture {
         withAnimation(.linear(duration: 3)) {
         rows = 8
         columns = 16
         }
         }
         */
        
        VStack(spacing: 0) {
            Spacer()
            
            Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: graphAmount)
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                .frame(width: 300, height: 300)
            
            Spacer()
            
            Group {
                Text("Inner radius: \(Int(innerRadius))")
                Slider(value: $innerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Outer radius: \(Int(outerRadius))")
                Slider(value: $outerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Distance: \(Int(distance))")
                Slider(value: $distance, in: 1...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Amount: \(graphAmount, format: .number.precision(.fractionLength(2)))")
                Slider(value: $graphAmount)
                    .padding([.horizontal, .bottom])
                
                Text("Color")
                Slider(value: $hue)
                    .padding(.horizontal)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
