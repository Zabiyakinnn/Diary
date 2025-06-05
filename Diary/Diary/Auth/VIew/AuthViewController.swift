//
//  AuthViewController.swift
//  Diary
//
//  Created by Дмитрий Забиякин on 05.06.2025.
//

import UIKit

final class AuthViewController: UIViewController {
    
    private let authView = AuthView()
    
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
    }
    
    @objc private func showPasswordTapped() {
        authView.passwordUser.isSecureTextEntry.toggle()
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
