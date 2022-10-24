import Foundation

//: 반환하기
func rollDice() -> Int {
    return Int.random(in: 1...6)
}

let result = rollDice()
print(result)

//: 코드 한줄일 때 return 생략가능합니다
func areLettersIdentical(string1: String, string2: String) -> Bool {
    string1.sorted() == string2.sorted()
}
