
# 1. ObservableObject 클래스를 인코딩하는 방법

기존의 Order모델은 여러화면에서 데이터를 공유하기 위해 @Published 프로퍼티를 사용했지만 Codable을 하기위해서는 타입이 Codable을 채택하지 않아서 Encoding, Decoding하는 방법을 작성해야 합니다.

> Order 모델 Codable프로토콜 채택하는 예시

```swift
// MARK: -  모델
class Order: ObservableObject, Codable {
    static let types = ["바닐라", "딸기", "초콜릿", "믹스"]    // 케이크 유형
    
    @Published var type = 0
    @Published var quantity = 3                                             // 주문하려는 케이크의 수
    
    @Published var extraFrosting = false                                    // 케이크에 추가 프로스팅을 원하는지에 대한 여부
    @Published var addSprinkles = false                                     // 케이크에 스프링클을 추가할지에 대한 여부
    
    // MARK: - 배송 정보 관련
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    init() { }
    
    // 1. 코딩키 작성
    enum CodingKeys: CodingKey {
        case type
        case quantity
        case extraFrosting
        case addSprinkles
        case name
        case streetAddress
        case city
        case zip
    }
    
    // 2. encode(to:)메서드 구현
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // 오류를 던져도 자동으로 위쪽으로 던져지고 다른 곳에서 처리되므로 catch를 작성할 필요가 없다.
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)

        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)

        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    // 3. decoder 구현
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)

        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)

        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
}

```

-   정적타입은 CodingKey에 추가하지 않아도 됩니다.
-   CodingKey를 작성하고 encode(to:)와 init(from decoder: Decoder)를 구현합니다.
-   throw로 작성되어도 오류를 던져도 자동으로 위쪽으로 던져지고 다른 곳에서 처리되므로 catch를 작성할 필요가 없다.
-   기존에 클래스 인스턴스를 생성할 때 init(from:) 이니셜라이저를 생성했기 때문에 또 다른 init() {} 이니셜라이저를 추가하여 codable이 필요한 경우에만 decoder이니셜라이저를 사용할 수 있습니다.
    -   클래스는 여러 이니셜라이저를 추가할 수 있습니다.

# 2. 인터넷(네트워크)로 부터 데이터 주고 받는 방법

URLSession클래스와 함께 Codable을 채택한 Swift객체를 JSON으로 변환하여 새로운 URLRequest구조체를 구성하여 데이터를 보낼 수 있습니다.

> Order객체 데이터 URLSession으로 업로드하는 예시

```swift
// MARK: - CheckOutView
struct CheckoutView: View {
    @ObservedObject var order: Order
    
    // 네트워크 확인용
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "<https://hws.dev/img/cupcakes@3x.jpg>"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("총 비용은 \\(order.cost, format: .currency(code: "USD"))입니다.")
                    .font(.title)
                
                // 버튼이 눌렸을 때 액션이 실행되므로 수정자가 아닌 Task를 생성합니다.
                Button("주문 완료") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("주문하기")
        .navigationBarTitleDisplayMode(.inline)
        .alert("네트워크 성공", isPresented: $showingConfirmation) {
            Button("확인") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        // 1. Swift객체 -> JSON 인코딩
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("인코딩 에러")
            return
        }
        
        // 2. URLRequest를 사용하여 HTTP방식 및 헤더를 구성합니다.
        let url = URL(string: "<https://reqres.in/api/cupcakes>")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // 3. 업로드 요청
        do {
            // 해당 API는 성공시 동일한 JSON값을 응답합니다
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "총 주문 갯수는 \\(decodedOrder.quantity)이고 \\(Order.types[decodedOrder.type].lowercased()) 컵케이크 입니다!"
            showingConfirmation = true

        } catch {
            print("업로드 실패.")
        }
    }
    
}

```

-   버튼이 눌렸을 때 액션이 실행되므로 task()수정자가 아닌 Task를 생성합니다.
