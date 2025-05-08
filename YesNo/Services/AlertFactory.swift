import Foundation

struct AlertFactory {
    
    static func createAlert(for error: AppError, onDismiss: @escaping () -> Void = {}) -> AlertModel {
        let (title, message) = errorInfo(for: error)
        return AlertModel(
            title: title,
            message: message,
            buttonText: "ОК",
            completion: onDismiss
        )
    }
    
    private static func errorInfo(for error: AppError) -> (String, String) {
        switch error {
        case .timeoutError:
            return ("Ошибка соединения", "Произошёл тайм-аут. Проверьте интернет.")
        case .network:
            return ("Сетевая ошибка", "Проверьте соединение и повторите попытку.")
        case .noData:
            return ("Нет данных", "Сервер не вернул данные.")
        case .codeError:
            return ("Ошибка", "Сервер вернул некорректный статус ответа.")
        case .decoding(let decodingError):
            return ("Ошибка данных", "Не удалось обработать данные: \(decodingError.localizedDescription)")
        }
    }
}
