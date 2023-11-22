//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by 수킴 on 2022/12/14.
//

import SwiftUI

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
