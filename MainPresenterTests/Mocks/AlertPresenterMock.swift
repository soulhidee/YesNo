import Foundation
@testable import YesNo

final class AlertPresenterMock: AlertPresenterProtocol {
    var showAlertCalled = false
    var receivedAlertModel: AlertModel?
    
    func show(alert model: AlertModel) {
        showAlertCalled = true
        receivedAlertModel = model
        model.completion()
    }
}
