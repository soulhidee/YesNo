import Foundation
@testable import YesNo

final class GifLoaderMock: GifLoading {
    var loadGifCalled = false
    var resultToReturn: Result<GifResponse, Error>?
    
    func loadGif(handler: @escaping (Result<YesNo.GifResponse, Error>) -> Void) {
        loadGifCalled = true
        
        if let result = resultToReturn {
            handler(result)
        }
    }
}
