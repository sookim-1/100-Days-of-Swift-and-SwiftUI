//
//  CheckOutView.swift
//  CupcakeCorner
//
//  Created by 수킴 on 2022/12/14.
//

import SwiftUI


// MARK: - CheckOutView
struct CheckoutView: View {
    @ObservedObject var order: Order
    
    // 네트워크 확인용
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("총 비용은 \(order.cost, format: .currency(code: "USD"))입니다.")
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
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // 3. 업로드 요청
        do {
            // 해당 API는 성공시 동일한 JSON값을 응답합니다
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "총 주문 갯수는 \(decodedOrder.quantity)이고 \(Order.types[decodedOrder.type].lowercased())컵케이크 입니다!"
            showingConfirmation = true

        } catch {
            print("업로드 실패.")
        }
    }
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
