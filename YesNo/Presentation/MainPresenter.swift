import Foundation

final class MainPresenter {
    private weak var view: MainViewProtocol?
    private let gifLoader: GifLoading
    private let soundManager: SoundManager
    private var currentAnswer: String?
    
    init(
        view: MainViewProtocol,
        gifLoader: GifLoading = GifLoader(),
        soundManager: SoundManager = SoundManager()
    ) {
        self.view = view
        self.gifLoader = gifLoader
        self.soundManager = soundManager
    }
}
