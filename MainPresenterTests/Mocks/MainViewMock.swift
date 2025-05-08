import Foundation
@testable import YesNo

final class MainViewMock: MainViewProtocol {
    var changeButtonTextColorCalled = false
    
    var animateElementsOutCalled = false
    
    var enableButtonCalled = false
    var enableButtonHandler: ((Bool) -> Void)?
    
    var loadGifInWebViewCalled = false
    var loadGifInWebViewHandler: ((String) -> Void)?
    
    var setActivityIndicatorCalled = false
    var setActivityIndicatorHandler: ((Bool) -> Void)?
    
    
    func animateElementsOut() {
        animateElementsOutCalled = true
    }
    
    func loadGifInWebView(from urlString: String) {
        loadGifInWebViewCalled = true
        loadGifInWebViewHandler?(urlString)
    }
    
    func changeButtonTextColor() {
        changeButtonTextColorCalled = true
    }
    
    func setActivityIndicator(visible: Bool) {
        setActivityIndicatorCalled = true
        setActivityIndicatorHandler?(visible)
    }
    
    func enableButton(_ enabled: Bool) {
        enableButtonCalled = true
        enableButtonHandler?(enabled)
    }
    
    
}
