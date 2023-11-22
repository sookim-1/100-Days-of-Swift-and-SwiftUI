import UIKit

let weather = "snow"

switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
    fallthrough
case "sunny":
    print("Wear sunscreen")
default:
    print("Enjoy your day!")
}

let todayWeather = "snow"

switch todayWeather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
    fallthrough
case "sunny":
    print("Wear sunscreen")
default:
    print("Enjoy your day!")
}
