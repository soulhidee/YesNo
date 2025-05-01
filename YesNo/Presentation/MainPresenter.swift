import Foundation

final class MainPresenter {
    private weak var view: MainViewProtocol?
    private let gifLoader: GifLoading
    private let soundManager: SoundManager
    private var currentAnswer: String?
}
