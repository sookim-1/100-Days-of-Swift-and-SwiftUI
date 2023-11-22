//: [Previous](@previous)

import Foundation

enum WeatherType {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}

func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "meh"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}

getHaterStatus(weather: WeatherType.cloud) // dislike
getHaterStatus(weather: WeatherType.wind(speed: 6)) // meh
getHaterStatus(weather: WeatherType.wind(speed: 16)) // dislike


//: [Next](@next)
