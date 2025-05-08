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
    
    func testActionButtonTapped() throws {
        presenter.actionButtonTapped()
        
        mainView.enableButtonHandler = { enabled in
            XCTAssertFalse(enabled)
        }
        
        XCTAssertTrue(mainView.changeButtonTextColorCalled, "Должен быть вызван changeButtonTextColor")
        XCTAssertTrue(mainView.enableButtonCalled, "Должен быть вызван enableButton")
        XCTAssertTrue(gifLoader.loadGifCalled, "Должен быть вызваен loadGif")
    }
    
    func testLoadGifSuccess() throws {
        let expectedURL = "https://test.com/gif"
        let expectedAnswer = "yes"
        
        gifLoader.resultToReturn = .success(
            GifResponse(gif: expectedURL, answer: expectedAnswer)
        )
        
        let gifLoaderExpecration = expectation(description: "Гифка должна быть загружена во view")
        let activityIndicatorExpectation = expectation(description: "Индикатор должен быть скрыт после загрузки загрузки")
        
        mainView.loadGifInWebViewHandler = { urlString in
            XCTAssertEqual(urlString, expectedURL, "URL гифки должен совпадать")
            gifLoaderExpecration.fulfill()
        }
        
        mainView.setActivityIndicatorHandler = { visible in
            if visible {
                XCTAssertTrue(visible, "ActivityIndicator должен быть показан")
            } else {
                activityIndicatorExpectation.fulfill()
            }
        }
        
        presenter.loadGifIfNeeded()
        
        wait(for: [gifLoaderExpecration, activityIndicatorExpectation], timeout: 1.0)
        
        XCTAssertTrue(gifLoader.loadGifCalled, "Метод loadGif должен быть вызван")
        XCTAssertTrue(mainView.setActivityIndicatorCalled, "Метод setActivityIndicator должен быть вызван")
        XCTAssertTrue(mainView.loadGifInWebViewCalled, "Метод loadGifInWebView должен быть вызван")
        XCTAssertEqual(presenter.getNormalizedAnswer(), expectedAnswer, "Ответ должен быть сохранен корректно")
    }
    
    
}
