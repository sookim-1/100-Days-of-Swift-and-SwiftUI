import Foundation

//: static
struct School {
    static var studentCount = 0

    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}

School.add(student: "Taylor Swift")
print(School.studentCount)

School.add(student: "Sookim")
print(School.studentCount)

//: static과 non-static 같이 사용하기
struct FoodSchool {
    static var foodCount = 0
    var foodName: String

    static func add(food: String) {
        print("\(food) joined the school.")
        foodCount += 1
    }
    
    func printFoodCount() {
        print("total Count: \(FoodSchool.foodCount)")
        print("total Count: \(Self.foodCount)")
    }
}

let foodSchool = FoodSchool(foodName: "Pizza")
foodSchool.printFoodCount()

