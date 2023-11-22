import Foundation

//: 삼항연산자를 활용하여 바로 상수 및 변수생성
let age = 18
let canVote = age >= 18 ? "Yes" : "No"

//: 조건 괄호로 감싸기
enum Theme {
    case light, dark
}

let theme = Theme.dark

let background = (theme == .dark) ? "black" : "white"
print(background)
