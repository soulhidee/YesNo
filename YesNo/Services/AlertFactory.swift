import Foundation

struct AlertFactory {
    
    static func networkError(error: AppError, buttonText: String = "ОК", onDismiss: (() -> Void)? = nil) -> AlertModel {
        return AlertModel(
            title: "Ошибка сети",
            message: error.localizedDescription,
            buttonText: buttonText,
            onDismiss: onDismiss
        )
    }
}
