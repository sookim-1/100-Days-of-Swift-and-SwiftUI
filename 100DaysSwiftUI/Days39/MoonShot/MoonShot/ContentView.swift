//
//  ContentView.swift
//  MoonShot
//
//  Created by 수킴 on 2022/12/12.
//

import SwiftUI

struct CustomText: View {
    let text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        // 스크롤뷰 들어가자마자 100번호출됩니다. 따라서 LazyStack을 사용하여 해결가능
        print("텍스트를 생성합니다.")
        self.text = text
    }
}

// MARK: - 계층 구조 Codable
struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct ContentView: View {
    
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]
    
    var body: some View {
        // MARK: - 이미지 리사이징
        /*
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
        
        // MARK: - GeometryReader뷰
        
        GeometryReader { geo in
            Image("aldrin")
                .resizable()
                .scaledToFit()
                .frame(width: geo.size.width * 0.8, height: 300)
        }
        
        GeometryReader { geo in
            Image("aldrin")
                .resizable()
                .scaledToFit()
                .frame(width: geo.size.width * 0.8)
                .frame(width: geo.size.width, height: geo.size.height)
        }
         
        // MARK: - ScrollView
        ScrollView {
            VStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText("Item \($0)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
        }
        
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText("Item \($0)")
                        .font(.title)
                }
            }
        }
        
        
        // MARK: - NavigationLink
        NavigationView {
            NavigationLink {
                Text("Detail View")
            } label: {
                Text("Hello, world!")
                    .padding()
            }
            .navigationTitle("SwiftUI")
        }
        
        NavigationView {
            List(0..<100) { row in
                if row != 1 {
                    NavigationLink {
                        Text("Detail \(row)")
                    } label: {
                        Text("Row \(row)")
                    }
                } else {
                    Text("Row \(row)")
                }
            }
            .navigationTitle("SwiftUI")
        }
        
        // MARK: - Codable
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
        */
        
        // MARK: - 그리드
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
        
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
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
