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
    
    var passwordOne: String {
        registrView.passwordUser.text ?? ""
    }
    
    var passwordTwo: String {
        registrView.returnPasswordUser.text ?? ""
    }
        
//    MARK: LoadView
    override func loadView() {
        super.loadView()
        self.view = registrView
    }
    
//    MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addDismissKeyboardGesture()
        setupUI()
        
        setupButton()
    }
    
    private func setupButton() {
        registrView.registrButton.addTarget(self, action: #selector(registrButtonTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        registrView.passwordUser.addTarget(self, action: #selector(passwordFieldsDidChange), for: .editingChanged)
        registrView.returnPasswordUser.addTarget(self, action: #selector(passwordFieldsDidChange), for: .editingChanged)
    }
    
    @objc private func passwordFieldsDidChange() {
        
        let result = viewModel.checkPassword(passwordOne, passwordTwo)
        switch result {
        case .done:
            showPasswordMatchIcon(success: true)
        case .misDone:
            showPasswordMatchIcon(success: false)
        case .toShort:
            removePasswordMatchIcon()
        case .empty:
            removePasswordMatchIcon()
        }
    }

    
    @objc func registrButtonTapped() {
        
        let result = viewModel.checkPassword(passwordOne, passwordTwo)
        switch result {
        case .done:
            print("Совпадают")
            // положительный результат, регистрация
        case .misDone:
            print("Не совпадают")
            //alert с ошибкой что пароли не совпали
            showAlert(title: "Ошибка", massage: "Пароли не совпадают")
        case .toShort:
            print("короткий пароль")
            //alert с ошибкой что пароль слишком короткий
            showAlert(title: "Ошибка", massage: "Пароль должен содержать более шести символов")
        case .empty:
            print("Остальное")
            showAlert(title: "Ошибка", massage: "Заполните все поля и повторите попытку")
        }
    }
    
    //добавить значок совпадает/не совпадает пароль
    private func showPasswordMatchIcon(success: Bool) {
        let systemName = success ? "checkmark.circle.fill" : "xmark.circle.fill"
        let color = success ? UIColor.systemGreen : UIColor.systemRed
        
        let imageView = UIImageView(image: UIImage(systemName: systemName))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = color
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        imageView.frame = CGRect(x: 5, y: 0, width: 25, height: 20)
        containerView.addSubview(imageView)
        
        registrView.returnPasswordUser.rightView = containerView
        registrView.returnPasswordUser.rightViewMode = .always
    }
    
    //убираем значок
    private func removePasswordMatchIcon() {
        registrView.returnPasswordUser.rightView = nil
        registrView.returnPasswordUser.rightViewMode = .never
    }
    
    //показать ошибку
    private func showAlert(title: String, massage: String) {
        let alertController = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
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
