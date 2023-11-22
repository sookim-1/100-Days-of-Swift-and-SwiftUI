import Foundation

//: 중첩 조건문
let temp = 25

if temp > 20 {
    if temp < 30 {
        print("It's a nice day.")
    }
}

//: && 논리연산자
if temp > 20 && temp < 30 {
    print("It's a &&")
}

//: || 논리연산자
if temp > 20 || false {
    print("It's a ||")
}
