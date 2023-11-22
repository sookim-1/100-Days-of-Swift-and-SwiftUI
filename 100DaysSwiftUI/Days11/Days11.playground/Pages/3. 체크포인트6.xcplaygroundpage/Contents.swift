import Foundation

//: 모델명, 좌석 수, 기어를 포함한 자동차 구조체를 만들고 기어를 위아래로 변경하는 메서드를 추가합니다.
struct Car {
    let modelName: String
    let seatCount: Int
    var gear: Int {
        didSet {
            print("변경전 기어단계 :\(oldValue)")
            print("현재 기어단계 :\(gear)")
        }
    }
    
    mutating func upGear() {
        gear += 1
    }
    
    mutating func downGear() {
        gear -= 1
    }
}

var car = Car(modelName: "K5", seatCount: 5, gear: 0)
car.upGear()
car.upGear()
car.downGear()

