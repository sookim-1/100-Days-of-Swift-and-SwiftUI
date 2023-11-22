import Foundation

//: 동물에 대한 클래스계층구조 생성
class Animal {
    var legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
    
    func speak() {
        print("My Animal")
    }
}

class Dog: Animal {
}

class Corgi: Dog {
    override func speak() {
        print("My Dog Name is Corgi")
    }
}

class Poodle: Dog {
    override func speak() {
        print("My Dog Name is Poodle")
    }
}

class Cat: Animal {
    var isTame: Bool
    
    init(isTame: Bool, legs: Int) {
        self.isTame = isTame
        super.init(legs: legs)
    }
}

class Persian: Cat {
    
}

class Lion: Cat {
    
}
