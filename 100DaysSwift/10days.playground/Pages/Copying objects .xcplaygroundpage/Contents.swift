//: [Previous](@previous)

import Foundation

struct Singer {
    var name = "Taylor Swift"
}

var singer = Singer()

var singerCopy = singer
singerCopy.name = "Justin Bieber"

print(singer.name)
print(singerCopy.name)

//class Statue {
//    var sculptor = "Unknown"
//}
//var venusDeMilo = Statue()
//venusDeMilo.sculptor = "Alexandros of Antioch"
//var david = Statue()
//david.sculptor = "Michaelangelo"
//print(venusDeMilo.sculptor)
//print(david.sculptor)

class Statue {
    var sculptor = "Unknown"
}
var example = Statue()
var venusDeMilo = example
venusDeMilo.sculptor = "Alexandros of Antioch"
var david = example
david.sculptor = "Michaelangelo"
print(venusDeMilo.sculptor)
print(david.sculptor)


//: [Next](@next)
