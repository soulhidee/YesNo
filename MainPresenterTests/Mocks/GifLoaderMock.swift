import Foundation
@testable import YesNo

final class GifLoaderMock: GifLoading {
    var loadGifCalled = false
    
    func loadGif(handler: @escaping (Result<YesNo.GifResponse, Error>) -> Void) {
        loadGifCalled = true
    }
}
