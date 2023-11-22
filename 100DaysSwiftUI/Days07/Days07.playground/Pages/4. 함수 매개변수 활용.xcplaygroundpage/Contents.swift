import Foundation

//: 기본 매개변수 사용법
func isUppercase(string: String) -> Bool {
    string == string.uppercased()
}

let result = isUppercase(string: "HELLO, WORLD")


//: 와일드카드 사용하기
func isUppercaseNoExternalLabel(_ string: String) -> Bool {
    string == string.uppercased()
}

let resultNoExternalLabel = isUppercaseNoExternalLabel("HELLO, WORLD")

//: 외부, 내부 매개변수명 다르게 사용하기
func printTimesTables(for number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5)
