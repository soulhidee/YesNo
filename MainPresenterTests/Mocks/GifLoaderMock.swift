import Foundation
@testable import YesNo

final class GifLoaderMock: GifLoading {
    var loadGifCalled = false
    var resultToReturn: Result<GifResponse, Error>?

    var loadGifStub: ((@escaping (Result<GifResponse, Error>) -> Void) -> Void)?

    func loadGif(handler: @escaping (Result<GifResponse, Error>) -> Void) {
        loadGifCalled = true

        if let stub = loadGifStub {
            stub(handler)
        } else if let result = resultToReturn {
            handler(result)
        }
    }
}
