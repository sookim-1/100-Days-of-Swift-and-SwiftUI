import Foundation

//: private
struct BankAccount {
    private var funds = 0

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount()
account.deposit(amount: 300)
let success = account.withdraw(amount: 200)

if success {
    print("Withdrew money successfully")
} else {
    print("Failed to get the money")
}

//: get, set 접근제어 다르게 적용하기
public struct Car {
  private(set) var engine: String
}

var car = Car(engine: "$10")
print(car.engine)
// 에러 car.engine = "$"
print(car.engine)
