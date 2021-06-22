//: [Previous](@previous)

import Foundation

class Album {
    var name: String

    init(name: String) {
        self.name = name
    }

    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}

class StudioAlbum: Album {
    var studio: String

    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class LiveAlbum: Album {
    var location: String

    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

// MARK: - 그냥 사용했을 경우 타입캐스팅을 하지 않아도 메서드 사용 가능합니다.
for album in allAlbums {
    print(album.getPerformance())
}

// MARK: - StudioAlbum, LiveAlbum에서 그들만의 속성을 사용하려고하는 경우 타입캐스팅이 필요합니다.
for album in allAlbums {
    print(album.getPerformance())

    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
}

for album in allAlbums {
    let studioAlbum = album as! StudioAlbum
    print(studioAlbum.studio)
}

// MARK: - 배열 수준에서 다운캐스팅
for album in allAlbums as? [LiveAlbum] ?? [LiveAlbum]() {
    print(album.location)
}

for album in allAlbums as! [StudioAlbum] {
    print(album.studio)
}


//: [Next](@next)
