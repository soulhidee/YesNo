import Foundation

extension Error {
    func toAppError() -> AppError {
        if let urlError = self as? URLError {
            if urlError.code == .timedOut {
                return .timeoutError
            } else {
                return .network(urlError)
            }
        }
        
        if let decodingError = self as? DecodingError {
            return .decoding(decodingError)
        }
        
        return .network(self)
    }
}
