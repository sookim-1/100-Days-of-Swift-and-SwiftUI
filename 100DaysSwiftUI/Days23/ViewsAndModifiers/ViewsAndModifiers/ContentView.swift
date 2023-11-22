//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by 수킴 on 2022/11/10.
//

import SwiftUI

struct ContentView: View {
    
    @State private var useRedText = false

    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
    
    var body: some View {
        Form {
            Section {
                // SwiftUI의 뷰의 계층관계
                Text("Hello, world!")
                    .padding()
                    .background(.red)
                
                Text("Hello, world!")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.red)
            }
            
            Section {
                // 뷰의 타입
                Button("Hello, world!") {
                    print(type(of: self.body))
                }
                .background(.red)
                .frame(width: 200, height: 200)
                
                Button("Hello, world!") {
                    print(type(of: self.body))
                }
                .frame(width: 200, height: 200)
                .background(.red)
                
                Text("Hello, world!")
                    .padding()
                    .background(.red)
                    .padding()
                    .background(.blue)
                    .padding()
                    .background(.green)
                    .padding()
                    .background(.yellow)
            }
            
            Section {
                // 조건수정자
                Button("Hello World") {
                    useRedText.toggle()
                }
                .foregroundColor(useRedText ? .red : .blue)
            }
            
            Section {
                // 환경수정자
                VStack {
                    Text("Gryffindor")
                        .font(.largeTitle)
                    Text("Hufflepuff")
                    Text("Ravenclaw")
                    Text("Slytherin")
                }
                .font(.title)
                
                VStack {
                    Text("Gryffindor")
                        .blur(radius: 0)
                    Text("Hufflepuff")
                        .blur(radius: 5)
                    Text("Ravenclaw")
                        .blur(radius: 5)
                    Text("Slytherin")
                        .blur(radius: 5)
                }
                
                VStack {
                    Text("Gryffindor")
                        .blur(radius: 0)
                    Text("Hufflepuff")
                    Text("Ravenclaw")
                    Text("Slytherin")
                }
                .blur(radius: 5)
            }
            
            Section {
                // 뷰 계층 구조 프로퍼티로 사용
                VStack {
                    motto1
                        .foregroundColor(.red)
                    motto2
                        .foregroundColor(.blue)
                }
                
                computedView1
                computedView2
                computedView3
                computedView4
            }
            
            Section {
                // 뷰 나누는 방법
                CapsuleText(text: "test")
            }
            
            Section {
                // 커스텀 수정자
                Text("Hello World")
                    .modifier(Title())
                
                Text("Hello World")
                    .titleStyle()
                
                Color.blue
                    .frame(width: 300, height: 200)
                    .watermarked(with: "Swift")
            }
            
            Section {
                // 커스텀 컨테이너
                GridStack(rows: 4, columns: 4) { row, col in
                    Image(systemName: "\(row * 4 + col).circle")
                    Text("R\(row) C\(col)")
                }
            }
        }
    }
}


var computedView1: some View {
    Text("Draco dormiens")
}

// 1. 스택에 배치
var computedView2: some View {
    VStack {
        Text("Lumos")
        Text("Obliviate")
    }
}

// 2. Group, Section을 통해 배치
var computedView3: some View {
    Group {
        Text("Lumos")
        Text("Obliviate")
    }
}

// 3. @ViewBuilder 어노테이션을 추가
@ViewBuilder var computedView4: some View {
    Text("Lumos")
    Text("Obliviate")
}

// MARK: - 뷰 분리하기
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

// MARK: - 커스텀 수정자
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

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

// MARK: - 커스텀 컨테이너
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
