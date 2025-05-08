import XCTest
@testable import YesNo

final class MainPresenterTests: XCTestCase {
    
    var mainView: MainViewMock!
    var gifLoader: GifLoaderMock!
    var presenter: MainPresenter!
    var alertPresenter: AlertPresenterMock!
    
    override func setUp() {
        super.setUp()
        mainView = MainViewMock()
        gifLoader = GifLoaderMock()
        alertPresenter = AlertPresenterMock()
        presenter = MainPresenter(view: mainView, gifLoader: gifLoader, alertPresenter: alertPresenter)
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
    
    func testLoadGifFailure() throws {
        let error = URLError(.timedOut)
        var loadGifCallCount = 0
        
        gifLoader.loadGifStub = { handler in
            loadGifCallCount += 1
            
            if loadGifCallCount == 1 {
                handler(.failure(error))
            } else {
                handler(.success(GifResponse(gif: "https://test.com", answer: "yes")))
            }
            
        }
        
        let expectation = expectation(description: "Повторная загрузка после ошибки и скрытие индикатора")
        
        mainView.setActivityIndicatorHandler = { visible in
              if !visible && loadGifCallCount == 2 {
                  expectation.fulfill()
              }
          }
        
        presenter.loadGifIfNeeded()
        
        wait(for: [expectation], timeout: 2.0)
        
        XCTAssertTrue(alertPresenter.showAlertCalled, "Алерт должен быть показан при ошибке загрузки")
        XCTAssertEqual(loadGifCallCount, 2, "loadGif должен быть вызван дважды: изначально и после повтора")
    }
    
    func testGetFormattedAnswer() throws {
        presenter.setTestAnswer("yes")
        let result = presenter.getFormattedAnswer()
        XCTAssertEqual(result, "Yes")
    }
    
    func testGetNormalizedAnswer() throws {
        presenter.setTestAnswer("YES")
        let result = presenter.getNormalizedAnswer()
        XCTAssertEqual(result, "yes")
    }
}
