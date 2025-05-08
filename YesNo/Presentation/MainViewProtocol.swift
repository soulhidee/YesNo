import Foundation
import UIKit

protocol MainViewProtocol: AnyObject {
    func animateElementsOut()
    func loadGifInWebView(from urlString: String)
    func changeButtonTextColor()
    func setActivityIndicator(visible: Bool)
    func enableButton(_ enabled: Bool)
    func showAlert(model: AlertModel)
}
