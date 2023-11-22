import UIKit

let vw = UIView()

UIView.animate(withDuration: 0.5, animations: {
    vw.alpha = 0
})

// MARK: - 후행클로저
UIView.animate(withDuration: 0.5) {
    vw.alpha = 0
}
