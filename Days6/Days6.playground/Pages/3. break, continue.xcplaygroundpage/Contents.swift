import Foundation

//: continue
let filenames = ["me.jpg", "work.txt", "sophie.jpg", "logo.psd"]

for filename in filenames {
    if filename.hasSuffix(".jpg") == false {
        continue
    }

    print("Found picture: \(filename)")
}

//: continue를 실행시킨 곳에서 사이클을 건너뜁니다.
let a = [1, 2, 3]

for num in a {
    continue
    print(num)
}

//: break
let number2 = 2
let number4 = 4
var multiples: [Int] = []

for i in 1...100 {
    if i.isMultiple(of: number2) && i.isMultiple(of: number4) {
        multiples.append(i)

        if multiples.count == 4 {
            break
        }
    }
}

print(multiples)
