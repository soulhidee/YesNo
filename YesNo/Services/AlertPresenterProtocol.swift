import Foundation

protocol AlertPresenterProtocol: AnyObject {
    func show(alert model: AlertModel)
}
