import UIKit

for i in 1...10 {
    if i % 2 == 1 {
        continue
    }

    print(i)
}

var hoursStudied = 0
var goal = 10

repeat {
    hoursStudied += 1
    if hoursStudied > 4 {
        goal -= 1
        continue
    }
    print("I've studied for \(hoursStudied) hours")
} while hoursStudied < goal

for i in 1...15 {
    let square = i * i
    if i == 8 {
        continue
    }
    print("\(i) squared is \(square)")
}
