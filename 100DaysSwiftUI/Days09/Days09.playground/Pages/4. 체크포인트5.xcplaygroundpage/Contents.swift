import Foundation

//: 짝수인 숫자를 필터링 한후, 오름차순으로 정렬, 문자형식 변경 후에 출력하도록 작성하기

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

let numLuckyNumbers = luckyNumbers
    .filter { (number: Int) in
        return (number % 2) != 0
    }
    .sorted {
        return $0 < $1
    }
    .map { (number: Int) in
        return "\(number) is a lucky number"
    }
    .compactMap {
        return $0
    }

for num in 0..<numLuckyNumbers.count {
    print(numLuckyNumbers[num])
}
