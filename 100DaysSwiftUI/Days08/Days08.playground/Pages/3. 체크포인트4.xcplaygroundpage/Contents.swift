import Foundation

//: 1 ~ 10000사이 정수의 제곱근을 반환하고 아닌 경우 에러 처리

enum MathError: Error {
    case toSmall
    case toBig
    case notSquare
}

func getSquare(num: Int) throws -> Int {
    if num < 1 {
        throw MathError.toSmall
    } else if num > 10_000 {
        throw MathError.toBig
    }
    
    for index in 1...Int(num) {
        if index * index == num {
            return num
        }
    }
    
    throw MathError.notSquare
}

do {
    try getSquare(num: 9)
} catch {
    print(error.localizedDescription)
}
