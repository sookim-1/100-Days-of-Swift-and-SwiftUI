//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by 수킴 on 2022/12/05.
//

import SwiftUI


// MARK: - @Published 프로퍼티래퍼 Codable 채택하기
class User: ObservableObject, Codable {
    @Published var name = "Soo Kim"
    var age: Int = 0
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

// MARK: - Codable 데이터 송수신 예시
struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    
    // codable 모델
    @State private var results: [Result] = []
    
    // form 유효성 검사
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
        
        // MARK: - AsyncImage
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
        
        /* 잘못된 예시
         AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"))
             .resizable()
             .frame(width: 200, height: 200)
         */
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            // Color.red
            ProgressView()
        }
        .frame(width: 200, height: 200)
        
        AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("이미지 로드 중 에러 발생")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
        
        // MARK: - form 유효성 검사
        Form {
            Section {
                TextField("이름", text: $username)
                TextField("이메일", text: $email)
            }

            Section {
                Button("계정 생성") {
                    print("계정 생성 클릭")
                }
            }
            .disabled(disableForm)
        }
    }
    
    // MARK: - API호출 비동기함수
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
