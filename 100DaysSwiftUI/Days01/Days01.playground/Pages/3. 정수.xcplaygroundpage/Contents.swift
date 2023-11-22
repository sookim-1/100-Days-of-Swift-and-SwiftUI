import Foundation


//: 크기가 큰 숫자에 밑줄 사용하여 가독성을 올리기
let reallyBig = 100_000_000

//: 사칙연산 (+, -, *, /)
let score = 10

let lowerScore = score - 2
let higherScore = score + 10
let doubledScore = score * 2
let squaredScore = score * score
let halvedScore = score / 2

//: 복합할당연산자
var counter = 10

counter += 5
counter *= 2
counter -= 10
counter /= 2

//: 다른 정수의 배수인지 확인하기
let number = 120
print(number.isMultiple(of: 3))
