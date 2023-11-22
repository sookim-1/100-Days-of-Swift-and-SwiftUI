//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by 수킴 on 2022/12/14.
//

import SwiftUI

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
                    
                    Stepper("케이크 수량 (최소 3개이상): \(order.quantity)", value: $order.quantity, in: 3...20)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
