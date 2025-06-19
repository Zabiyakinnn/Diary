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
        registrView.yesAccount.addTarget(self, action: #selector(yesAccountTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        registrView.passwordUser.addTarget(self, action: #selector(passwordFieldsDidChange), for: .editingChanged)
        registrView.returnPasswordUser.addTarget(self, action: #selector(passwordFieldsDidChange), for: .editingChanged)
    }
    
    @objc private func yesAccountTapped() {
        NotificationCenter.default.post(name: Notification.Name("routeVC"), object: nil, userInfo: ["vc": WindowCase.auth])
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
        registrView.activityIndicator.startAnimating()
        
        let result = viewModel.checkPassword(passwordOne, passwordTwo)
        switch result {
        case .done:
            print("Совпадают")
            // положительный результат, регистрация
            let email = registrView.emailUser.text
            let password = registrView.passwordUser.text
//            let userName = registrView.nameUser.text
//            NotificationCenter.default.post(name: Notification.Name("routeVC"), object: nil, userInfo: ["vc": WindowCase.auth])
            viewModel.registrUser(email: email ?? "", password: password ?? "", nameUser: "") { result in
                switch result {
                case .success(_):
                    NotificationCenter.default.post(name: Notification.Name("routeVC"), object: nil, userInfo: ["vc": WindowCase.auth])
                case .failure(let error):
                    var massage = "Неизвестная ошибка. Повторите попытку"
                    
                    if let emailVArification = error as? EmailVarification {
                        switch emailVArification {
                        case .invalidEmail:
                            massage = "Неверный Email"
                        case .emailAlreadyInUse:
                            massage = "Данный Email уже зарегистрирован"
                        case .networkError:
                            massage = "Ошибка с сетью. Повторите попытку"
                        case .otherError:
                            massage = "Неизвестная ошибка. Повторите попытку"
                        }
                    } else {
                        massage = error.localizedDescription
                    }
                    
                    self.showAlert(title: "Ошибка регистрации", massage: massage)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                self.registrView.activityIndicator.stopAnimating()
            }
        case .misDone:
            print("Не совпадают")
            //alert с ошибкой что пароли не совпали
            showAlert(title: "Ошибка", massage: "Пароли не совпадают")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.registrView.activityIndicator.stopAnimating()
            }
        case .toShort:
            print("короткий пароль")
            //alert с ошибкой что пароль слишком короткий
            showAlert(title: "Ошибка", massage: "Пароль должен содержать более шести символов")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.registrView.activityIndicator.stopAnimating()
            }
        case .empty:
            print("Остальное")
            showAlert(title: "Ошибка", massage: "Заполните все поля и повторите попытку")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.registrView.activityIndicator.stopAnimating()
            }
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
