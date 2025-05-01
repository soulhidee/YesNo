import Foundation
@testable import YesNo

final class GifLoaderMock: GifLoading {
    func loadGif(handler: @escaping (Result<YesNo.GifResponse, Error>) -> Void) {
        
    }
}
