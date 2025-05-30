//
//  RegistrViewController.swift
//  Diary
//
//  Created by Дмитрий Забиякин on 30.05.2025.
//

import UIKit
import SnapKit

final class RegistrViewController: UIViewController {
    
    private let registrView = RegistrView()
    private let viewModel = RegistrViewModel()
    
//    MARK: LoadView
    override func loadView() {
        super.loadView()
        self.view = registrView
    }
    
//    MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addDismissKeyboardGesture()
        setupButton()
    }
    
    private func setupButton() {
        registrView.registrButton.addTarget(self, action: #selector(registrButtonTapped), for: .touchUpInside)
    }
    
    @objc func registrButtonTapped() {
        let passwordOne = registrView.passwordUser.text
        let passwordTwo = registrView.returnPasswordUser.text
        
        let result = viewModel.checkPassword(passwordOne ?? "", passwordTwo ?? "")
        switch result {
        case .done:
            print("Совпадают")
        case .misDone:
            print("Не совпадают")
        case .toShort:
            print("короткий пароль")
        case .empty:
            print("Остальное")
        }
    }
}

//MARK: Keyboard
extension RegistrViewController {
    private func addDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
