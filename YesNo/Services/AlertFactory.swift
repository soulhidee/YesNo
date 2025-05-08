import Foundation

struct AlertFactory {
    static func createAlert(for error: AppError, onDismiss: @escaping () -> Void = {}) -> AlertModel {
        return AlertModel(
            title: "Ошибка",
            message: error.errorDescription ?? "Неизвестная ошибка",
            buttonText: "ОК",
            completion: onDismiss
        )
    }
}
