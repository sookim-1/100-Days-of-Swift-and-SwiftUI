import UIKit

struct Person {
    private var id: String

    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
        return "My social security number is \(id)"
    }
}

let ed = Person(id: "12345")
//ed.identify()

struct Office {
    private var passCode: String
    var address: String
    var employees: [String]
    init(address: String, employees: [String]) {
        self.address = address
        self.employees = employees
        self.passCode = "SEKRIT"
    }
}
let monmouthStreet = Office(address: "30 Monmouth St", employees: ["Paul Hudson"])

struct FacebookUser {
    private var privatePosts: [String]
    public var publicPosts: [String]
    
    init(pr: [String], pu: [String]) {
        privatePosts = pr
        publicPosts = pu 
    }
}
let user = FacebookUser(pr: ["ge"], pu: ["zf"])
