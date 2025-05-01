import XCTest
@testable import YesNo

final class MainPresenterTests: XCTestCase {
    
    var mainView: MainViewMock!
    var gifLoader: GifLoaderMock!
    var presenter: MainPresenter!
    
    override func setUp() {
        super.setUp()
        mainView = MainViewMock()
        gifLoader = GifLoaderMock()
        presenter = MainPresenter(view: mainView, gifLoader: gifLoader)
    }
    
    override func tearDown() {
        mainView = nil
        gifLoader = nil
        presenter = nil
        super.tearDown()
    }
}
