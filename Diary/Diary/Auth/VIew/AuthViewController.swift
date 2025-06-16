//
//  AuthViewController.swift
//  Diary
//
//  Created by Дмитрий Забиякин on 05.06.2025.
//

import UIKit

final class AuthViewController: UIViewController {
    
    private let authView = AuthView()
    private let viewModel = AuthViewModel()
    
//    MARK: LoadView
    override func loadView() {
        self.view = authView
    }
    
//    MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addDismissKeyboardGesture()
        
        setupButton()
    }
    
    private func setupButton() {
        authView.showPassword.addTarget(self, action: #selector(showPasswordTapped), for: .touchUpInside)
        authView.noAccount.addTarget(self, action: #selector(noAccountbuttonTapped), for: .touchUpInside)
        authView.enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
    }
    
    @objc private func showPasswordTapped() {
        authView.passwordUser.isSecureTextEntry.toggle()
    }
    
    @objc private func noAccountbuttonTapped() {
        NotificationCenter.default.post(name: Notification.Name("routeVC"), object: nil, userInfo: ["vc": WindowCase.registr])
    }
    
    @objc private func enterButtonTapped() {
        let email = authView.emailUser.text
        let password = authView.passwordUser.text
        
        viewModel.authUser(email: email ?? "", password: password ?? "") { result in
            switch result {
            case .success(_):
                NotificationCenter.default.post(name: Notification.Name("routeVC"), object: nil, userInfo: ["vc": WindowCase.home])
            case .failure(let failure):
                print("Ошибка авторизации \(failure)")
                //Alert с ошибкой
            }
        }
    }
}

//MARK: Keyboard
extension AuthViewController {
    private func addDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
