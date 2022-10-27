import Foundation

//: 3의 배수는 Fizz, 5의 배수는 Buzz, 3과 5의 배수는 FizzBuzz 나머지는 숫자를 출력합니다.

for i in 1...100 {
    if i.isMultiple(of: 15) {
        print("FizzBuzz")
    } else {
        if i.isMultiple(of: 3) {
            print("Fizz")
        } else if i.isMultiple(of: 5) {
            print("Buzz")
        } else {
            print(i)
        }
    }
}
