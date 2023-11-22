//
//  Order.swift
//  CupcakeCorner
//
//  Created by 수킴 on 2022/12/14.
//

import Foundation

// MARK: -  모델
class Order: ObservableObject, Codable {
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
