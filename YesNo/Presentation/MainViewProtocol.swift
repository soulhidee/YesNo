import Foundation
import UIKit

protocol MainViewProtocol: AnyObject {
    func animateElementsOut()
    func loadGifInWebView(from urlString: String)
    func enableButton()
    func disableButton()
    func changeButtonTextColor()
    func setActivityIndicator(visible: Bool)
}
