import SwiftUI

extension View {
    func alertWithTextField(
        title: String,
        message: String,
        placeholder: String,
        primaryTitle: String,
        secondarytitle: String,
        primaryAction: @escaping (String) -> Void,
        secondaryAction: @escaping () -> Void
    ) {
        let alert: UIAlertController = .init(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.placeholder = placeholder
        }
        
        alert.addAction(
            .init(
                title: primaryTitle,
                style: .default
            ) { _ in
                primaryAction(alert.textFields?[0].text ?? "")
            }
        )
        
        alert.addAction(
            .init(
                title: secondarytitle,
                style: .cancel
            ) { _ in
                secondaryAction()
            }
        )
        
        rootViewController.present(alert, animated: true)
    }
    
    private var rootViewController: UIViewController {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .windows
            .first?
            .rootViewController ?? .init()
    }
}
