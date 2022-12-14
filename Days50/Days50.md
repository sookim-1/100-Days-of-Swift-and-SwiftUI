
# 1. CupCake Corner 프로젝트 UI 구현하기

주문의 기본적인 세부사항들을 보여주는 주문화면 구현합니다.

단일 클래스인 데이터모델을 가지고 화면을 이동하며 동일한 데이터를 공유합니다.

예를 들어, Toggle이 모두 허용처럼 하위 Toggle들이 모두 동일하게 적용되어야 하는 경우 프로퍼티옵저버를 통해 처리할 수 있습니다.

> 모델 Order 예시 코드

```swift
// MARK: -  모델
class Order: ObservableObject {
    static let types = ["바닐라", "딸기", "초콜릿", "믹스"]    // 케이크 유형
    
    @Published var type = 0
    @Published var quantity = 3 // 주문하려는 케이크의 수
    
    // 특별요청을 원하는지에 대한 여부
    @Published var specialRequestEnabled = false  {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false  // 케이크에 추가 프로스팅을 원하는지에 대한 여부
    @Published var addSprinkles = false   // 케이크에 스프링클을 추가할지에 대한 여부
    
    // MARK: - 배송 정보 관련
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    // MARK: - 주문 관련
    var cost: Double {
        // 케이크 한개 당 2달러
        var cost = Double(quantity) * 2
        
        // 추가 비용
        cost += (Double(type) / 2)
        
        // 추가 비용
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // 추가 비용
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}

```

> ContentView 메인화면 예시

```swift
struct ContentView: View {
    
    @StateObject var order = Order() // 클래스이므로 모두 동일한 데이터로 작동합니다.
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    // 문자열배열이지만 정수로 저장하고 있기 때문에 indices를 각 항목의 위치를 얻습니다. (단, 배열의 순서가 변경되지 않는 경우에만 사용합니다.)
                    Picker("무슨 케이크를 원하세요?", selection: $order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("케이크 수량 (최소 3개이상): \\(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("추가 요청을 하시겠습니까?", isOn: $order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled {
                        Toggle("프로스팅 추가", isOn: $order.extraFrosting)
                        
                        Toggle("스프링클 추가", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("주소 입력하기")
                    }
                }
                
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

```

> AddressView 주소입력화면 예시

```swift
// MARK: - AddressView
struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("이름", text: $order.name)
                TextField("주소", text: $order.streetAddress)
                TextField("도시", text: $order.city)
                TextField("우편번호", text: $order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("주문하기")
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("주소 입력")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}

```

> CheckOutView 주문완료화면 예시


```swift
// MARK: - CheckOutView
struct CheckoutView: View {
    @ObservedObject var order: Order
    
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
                
                Button("주문 완료", action: { })
                    .padding()
            }
        }
        .navigationTitle("주문하기")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}

```
