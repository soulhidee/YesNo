import Foundation

enum AppError: LocalizedError {
    case codeError
    case noData
    case decoding(Error)
    case network(Error)
    case timeoutError
    
    var errorDescription: String? {
        switch self {
        case .codeError:
            return "Сервер вернул неверный статус ответа."
        case .noData:
            return "Нет данных от сервера."
        case .decoding(let error):
            return "Ошибка при декодировании данных: \(error.localizedDescription)"
        case .network(let error):
            return error.localizedDescription
        case .timeoutError:
            return "Ошибка соединения: Тайм-аут."
        }
    }
}
