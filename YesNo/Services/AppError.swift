import Foundation

enum AppError: LocalizedError {
    case codeError
    case noData
    case decoding(Error)
    case network(Error)
    case networkError404
    case networkError500
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
            return "Сетевая ошибка: \(error.localizedDescription)"
        case .networkError404:
            return "Ошибка 404: Страница не найдена."
        case .networkError500:
            return "Ошибка 500: Внутренняя ошибка сервера."
        case .timeoutError:
            return "Ошибка соединения: Тайм-аут."
        }
    }
}
