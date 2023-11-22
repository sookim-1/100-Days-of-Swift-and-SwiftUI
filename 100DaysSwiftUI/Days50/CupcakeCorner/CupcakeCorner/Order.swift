//
//  Order.swift
//  CupcakeCorner
//
//  Created by 수킴 on 2022/12/14.
//

import Foundation

// MARK: -  모델
class Order: ObservableObject {
    static let types = ["바닐라", "딸기", "초콜릿", "믹스"]    // 케이크 유형
    
    @Published var type = 0
    @Published var quantity = 3                                             // 주문하려는 케이크의 수
    
    // 특별요청을 원하는지에 대한 여부
    @Published var specialRequestEnabled = false  {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false                                    // 케이크에 추가 프로스팅을 원하는지에 대한 여부
    @Published var addSprinkles = false                                     // 케이크에 스프링클을 추가할지에 대한 여부
    
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
