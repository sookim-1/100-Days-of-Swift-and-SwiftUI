import Foundation

protocol Building {
    var roomCount: Int { get }
    var cost: Int { get }
    func buildingName(_ personName: String)
    func receipt()
}

extension Building {
    func receipt() {
        print("roomCount: \(roomCount), cost: \(cost)")
    }
}

struct House: Building {
    var roomCount = 5
    var cost = 500_000
    
    func buildingName(_ personName: String) {
        print("House")
    }
}

struct Office: Building {
    var roomCount = 2
    var cost = 100_000
    
    func buildingName(_ personName: String) {
        print("Office")
    }
}

let house = House()
house.buildingName("James")
house.receipt()
let office = Office()
office.buildingName("James")
office.receipt()
