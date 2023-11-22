import Foundation

//: 함수를 매개변수로 받아들이는 함수
func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers: [Int] = []

    // 전달받은 정수 만큼 반복
    for _ in 0..<size {
        // 반환된 정수를 추가
        let newNumber = generator()
        numbers.append(newNumber)
    }

    return numbers
}

let rolls = makeArray(size: 5) {
    Int.random(in: 1...20)
}

print(rolls)

//: 여러 함수를 매개변수로 받는 경우
func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("first")
    first()
    print("second")
    second()
    print("third")
    third()
    print("Done!")
}

doImportantWork {
    print("first-1")
} second: {
    print("second-1")
} third: {
    print("third-1")
}
