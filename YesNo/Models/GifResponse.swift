import Foundation

struct GifResponse: Decodable {
    let gif: String
    
    private enum CodingKeys: String, CodingKey {
        case gif = "image"
    }
}
