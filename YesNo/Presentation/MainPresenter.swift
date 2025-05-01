import Foundation

final class MainPresenter {
    
    // MARK: - Properties
    private weak var view: MainViewProtocol?
    private let gifLoader: GifLoading
    private var currentAnswer: String?
    
    // MARK: - Initializer
    init(
        view: MainViewProtocol,
        gifLoader: GifLoading = GifLoader()
    ) {
        self.view = view
        self.gifLoader = gifLoader
    }
    
    // MARK: - Actions
    func actionButtonTapped() {
        view?.changeButtonTextColor()
        view?.animateElementsOut()
        view?.disableButton()
        loadGif()
    }
    
    // MARK: - Private Methods
    private func loadGif() {
        view?.showActivityIndicator()
        gifLoader.loadGif { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let gifResponse):
                    self?.currentAnswer = gifResponse.answer
                    self?.view?.loadGifInWebView(from: gifResponse.gif)
                case .failure(let error):
                    print("Ошибка загрузки гифки: \(error.localizedDescription)")
                    self?.view?.hideActivityIndicator()
                }
            }
        }
    }
    
    // MARK: - Helpers
    func getFormattedAnswer() -> String? {
        return currentAnswer?.capitalized
    }
    
    func getNormalizedAnswer() -> String? {
        return currentAnswer?.lowercased()
    }
}
