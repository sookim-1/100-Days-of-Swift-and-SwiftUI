import Foundation

//: 옵셔널정수배열 중 옵셔널인 경우 1~100까지 난수 반환
var optionIntArray: [Int?] = [1, 2, nil, 3]

for i in 0..<optionIntArray.count {
    let unwrappingElement = optionIntArray[i] ?? Int.random(in: 1...100)
    
    print(unwrappingElement)
}
