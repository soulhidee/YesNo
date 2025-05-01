import Foundation
import UIKit

protocol MainViewProtocol: AnyObject {
    func animateElementsOut()
    func showActivityIndicator()
    func hideActivityIndicator()
    func loadGifInWebView(from urlString: String)
    func enableButton()
    func disableButton()
    func changeButtonTextColor()
}
