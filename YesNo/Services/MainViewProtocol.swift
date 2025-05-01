import Foundation

protocol MainViewProtocol: AnyObject {
    func showGif(with html: String, answer: String)
    func showLoading()
    func hideLoading()
    func enableButton()
    func disableButton()
}
