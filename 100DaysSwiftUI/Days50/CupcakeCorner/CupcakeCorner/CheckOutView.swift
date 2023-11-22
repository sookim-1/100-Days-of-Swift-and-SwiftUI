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
