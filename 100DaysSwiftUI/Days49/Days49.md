
# 1. 프로젝트 설명

Cupcake Corner 프로젝트 : 컵케이크 주문을 위한 앱

-   클래스가 Codable을 채택할 때 @Published 프로퍼티를 처리하는 방법
-   인터넷으로부터 데이터를 보내고 받는 방법
-   유효성을 검사하는 방법

----------

# 2. @Published 프로퍼티를 Codable 채택하는 방법

기본적으로 타입의 모든 프로퍼티가 Codable을 준수하고 있다면 타입이 Codable을 채택할 수 있습니다.

하지만, @Published 프로퍼티를사용하는 경우 추가작업이 필요합니다.

> @Published 프로퍼티를 Codable 준수하는 예시

```swift
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

```

-   String은 기본적으로 Codable을 준수하지만 @Published로 선언하면 Published<String>타입이 됩니다.
-   Published는 구조체이므로 구조체에 Codable을 기본으로 준수하지 않습니다.

1.  CodingKey에 로드하고 저장하려는 프로퍼티의 이름을 작성합니다.
2.  이니셜라이저를 통해 모든 프로퍼티의 값을 읽습니다. (디코딩하는 방법 정의)
    -   Decoder를 전달 받음으로써 모든 데이터를 포함하고 있습니다.
    -   required 키워드를 통해 서브클래스가 해당 이니셜라이저를 사용할 수 있게 합니다. (final 키워드를 작성하면 제거 가능)
    -   코딩키와 일치하는 컨테이너를 인스턴스에게 요청합니다.
    -   해당 컨테이너에서 직접 값을 읽습니다.
3.  encode 메서드를 구현합니다. (인코딩하는 방법 정의)
    -   Encoder를 인스턴스를 전달받고 코딩키를 통해 컨테이너를 생성합니다.
    -   각 키에 연결된 값을 작성합니다.

----------

# 3. URLSession과 SwiftUI로 Codable 데이터 전달하고 받는 방법

iOS는 인터넷과 데이터를 송수신하기 위해 Codable을 사용하면 Swift객체를 JSON으로 변환하여 전송하고 JSON을 수신하여 Swift객체로 변환할 수 있습니다.

-   task()수정자를 사용하면 비동기함수처리를 할 때 사용할 수 있습니다.

> Apple의 iTunes API에서 예제 음악 JSON로드하여 표시하는 예시

```swift
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
    
    @State private var results: [Result] = []
    
    var body: some View {
        List(results, id: \\.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
    
    // MARK: - API호출 비동기함수
    func loadData() async {
        guard let url = URL(string: "<https://itunes.apple.com/search?term=taylor+swift&entity=song>") else {
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

```

-   try await 키워드를 같이 사용하는 경우 try를 먼저 작성합니다.
-   data(from:) 의 반환 값은 메타데이터와, URL의 데이터를 튜플로 반환합니다.

----------

# 4. 서버에서 이미지를 가져오는 방법 (AsyncImage)

인터넷 및 서버에서 이미지를 로드하는 경우 AsyncImage를 사용하면 URL만 입력하면 이미지를 다운로드, 캐시 및 표시를 SwiftUI가 모든 작업을 처리합니다.

🚨 SwiftUI는 코드가 실행되고 이미지가 다운로드될 때까지 이미지에 대해 아무것도 알지 못하므로 사전에 적절하게 크기를 조정할 수 없습니다.

> AsyncImage 응용 예시

```swift
// MARK: - scale 조정
AsyncImage(url: URL(string: "<https://hws.dev/img/logo.png>"), scale: 3)

// MARK: - 이미지 크기 조정
AsyncImage(url: URL(string: "<https://hws.dev/img/logo.png>")) { image in
    image
        .resizable()
        .scaledToFit()
} placeholder: {
    Color.red
}
.frame(width: 200, height: 200)

// MARK: - phase로 상태 파악
AsyncImage(url: URL(string: "<https://hws.dev/img/bad.png>")) { phase in
    if let image = phase.image {
        image
            .resizable()
            .scaledToFit()
    } else if phase.error != nil {
        Text("이미지 로드 중 에러 발생.")
    } else {
        ProgressView()
    }
}
.frame(width: 200, height: 200)


```

scale 파라미터를 통해 로드하기전에 미리 지정할 수 있습니다.

frame 수정자를 통해 정확한 크기를 지정할 수 있습니다.

-   단, resizable() 과 함께 사용해도 지정할 수 없는 이유는 이미지데이터를 가져오기 전까지 적용방법을 알지 못하기 때문에 컴파일이 되지 않습니다.
-   따라서 이미지를 가져온 후 클로저형식으로 지정해야 합니다.

phase를 사용하여 이미지가 로드되었는지, 오류가 발생했는지, 로드를 하는 중인지에 대한 상태를 알 수 있습니다.

----------

# 5. Form에서 유효성 검사 및 비활성화 하는 방법

SwiftUI의 Form을 사용하면 사용자입력을 편리하게 저장할 수 있습니다.

disbled수정자를 통해 Form의 Section을 비활성화 할 수 있습니다.

> 이름 이메일 자릿수가 5개 이하인 경우 버튼 비활성화 예시

```swift
struct ContentView: View {

    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }

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

```
