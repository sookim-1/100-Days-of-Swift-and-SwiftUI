import Foundation

//: 매개변수에 기본값을 제공하는 방법
func printTimesTables(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5, end: 20)
printTimesTables(for: 8)

//: removeAll 옵션 기본값 - 기본 배열 용량 유지하려면 true옵션설정
var characters = ["Lana", "Pam", "Ray", "Sterling"]
characters.removeAll(keepingCapacity: true)
