import Foundation

protocol GifLoading {
    func loadGif(handler: @escaping (Result<GifResponse, Error>) -> Void)
}

struct GifLoader: GifLoading {
    
    private let networkClient = NetworkClient()
    
    private var gifUrl: URL {
        guard let url = URL(string: "https://yesno.wtf/api") else {
            preconditionFailure("Unable to construct gifUrl")
        }
        return url
    }
    
    func loadGif(handler: @escaping (Result<GifResponse, Error>) -> Void) {
        networkClient.fetch(url: gifUrl) { result in
            let decodedResult = result.flatMap { data in
                self.decode(GifResponse.self, from: data)
            }
            handler(decodedResult)
        }
    }
    
    private func decode<T: Decodable>(_ type: T.Type, from data: Data) -> Result<T, Error> {
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return .success(model)
        } catch {
            return .failure(AppError.decoding(error))
        }
    }
}

