import Foundation

struct GifResponse: Decodable {
    let gif: String
    let answer: String
    
    private enum CodingKeys: String, CodingKey {
        case gif = "image"
        case answer = "answer"
    }
}

