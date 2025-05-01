import Foundation
@testable import YesNo

final class MainViewMock: MainViewProtocol {
    var changeButtonTextColorCalled = false
    
    var animateElementsOutCalled = false
    
    var enableButtonCalled = false
    var enableButtonHandler: ((Bool) -> Void)?
    
    func animateElementsOut() {
        animateElementsOutCalled = true
    }
    
    func loadGifInWebView(from urlString: String) {
        
    }
    
    func changeButtonTextColor() {
        changeButtonTextColorCalled = true
    }
    
    func setActivityIndicator(visible: Bool) {
        
    }
    
    func enableButton(_ enabled: Bool) {
        enableButtonCalled = true
        enableButtonHandler?(enabled)
    }
    
    
}
