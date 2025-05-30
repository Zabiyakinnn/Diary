//
//  RegistrView.swift
//  Diary
//
//  Created by Дмитрий Забиякин on 30.05.2025.
//

import UIKit
import SnapKit

final class RegistrView: UIView {
    
    let placeholderText = UILabel()
    let attributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor(named: "ColorTextRegistrAuth") ?? .gray,
        .font: UIFont(name: "NTSomic-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.systemBackground
        
        setupLayout()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    Заголовок регистрация
    private lazy var registrText: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.textColor = UIColor(named: "ColorTextRegistrAuth")
        label.font = UIFont(name: "NTSomic-Bold", size: 27)
        return label
    }()

    
//    Текст "У вас уже есть аккаунт?"
    private lazy var textAccount: UILabel = {
        let label = UILabel()
        label.text = "У вас уже есть аккаунт?"
        label.textColor = UIColor(named: "ColorTextRegistrAuth")
        label.font = UIFont(name: "NTSomic-Medium", size: 15)
        return label
    }()
    
//    Кнопка для перехода на окно авторизации
    lazy var yesAccount: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = UIFont(name: "NTSomic-Medium", size: 15)
        button.setTitleColor(UIColor(named: "ColorTextRegistrAuth"), for: .normal)
        return button
    }()
    
//    Кнопка регистрации
    lazy var registrButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.setTitle("Зарегистрироваться", for: .normal)
        button.titleLabel?.font = UIFont(name: "NTSomic-Medium", size: 22)
        button.setTitleColor(UIColor(named: "ColorTextRegistrAuth"), for: .normal)
        return button
    }()
    
//    Поле ввода имени пользователя
    lazy var nameUser: UITextField = {
        let textField = UITextField()
        placeholderText.text = "Имя пользователя"
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText.text ?? "", attributes: attributes)
        
        let imageView = UIImageView(image: UIImage(systemName: "person"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "ColorTextRegistrAuth")

        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        imageView.frame = CGRect(x: 5, y: 0, width: 25, height: 20)
        containerView.addSubview(imageView)
        
        textField.leftView = containerView
        textField.leftViewMode = .always
        
        textField.font = UIFont(name: "NTSomic-Regular", size: 16)
        textField.textColor = UIColor(named: "ColorTextRegistrAuth")
        textField.backgroundColor = .clear

        return textField
    }()
    
    //    Поле ввода email
    lazy var emailUser: UITextField = {
        let textField = UITextField()
        placeholderText.text = "Email"
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText.text ?? "", attributes: attributes)
        
        let imageView = UIImageView(image: UIImage(systemName: "envelope"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "ColorTextRegistrAuth")
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        imageView.frame = CGRect(x: 5, y: 0, width: 25, height: 20)
        containerView.addSubview(imageView)
        
        textField.leftView = containerView
        textField.leftViewMode = .always
        
        textField.font = UIFont(name: "NTSomic-Regular", size: 16)
        textField.textColor = UIColor(named: "ColorTextRegistrAuth")
        textField.backgroundColor = .clear
        
        return textField
    }()
    
    //    Поле ввода пароля
    lazy var passwordUser: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry.toggle()
        placeholderText.text = "Придумайте пароль"
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText.text ?? "", attributes: attributes)
        
        let imageView = UIImageView(image: UIImage(systemName: "key.icloud"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "ColorTextRegistrAuth")
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        imageView.frame = CGRect(x: 5, y: 0, width: 25, height: 20)
        containerView.addSubview(imageView)
        
        textField.leftView = containerView
        textField.leftViewMode = .always
        
        textField.font = UIFont(name: "NTSomic-Regular", size: 16)
        textField.textColor = UIColor(named: "ColorTextRegistrAuth")
        textField.backgroundColor = .clear
        
        return textField
    }()
    
    //    Поле повторения пароля
    lazy var returnPasswordUser: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry.toggle()
        placeholderText.text = "Повторите пароль"
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText.text ?? "", attributes: attributes)
        
        let imageView = UIImageView(image: UIImage(systemName: "key.icloud"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "ColorTextRegistrAuth")
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        imageView.frame = CGRect(x: 5, y: 0, width: 25, height: 20)
        containerView.addSubview(imageView)
        
        textField.leftView = containerView
        textField.leftViewMode = .always
        
        textField.font = UIFont(name: "NTSomic-Regular", size: 16)
        textField.textColor = UIColor(named: "ColorTextRegistrAuth")
        textField.backgroundColor = .clear
        
        return textField
    }()
    
//    Разделительная линия
    private lazy var seperatorLineNameUser: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ColorTextRegistrAuth")
        return view
    }()
    
    private lazy var seperatorLineEmailUser: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ColorTextRegistrAuth")
        return view
    }()
    
    private lazy var seperatorLinePasswordUser: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ColorTextRegistrAuth")
        return view
    }()
    
    private lazy var seperatorLineReturnPasswordUser: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ColorTextRegistrAuth")
        return view
    }()
}

//MARK: SetupLayout
extension RegistrView {
    private func setupLayout() {
        addSubview(registrText)
        addSubview(nameUser)
        addSubview(emailUser)
        addSubview(passwordUser)
        addSubview(textAccount)
        addSubview(yesAccount)
        addSubview(registrButton)
        addSubview(returnPasswordUser)
        
        nameUser.addSubview(seperatorLineNameUser)
        nameUser.addSubview(seperatorLineEmailUser)
        nameUser.addSubview(seperatorLinePasswordUser)
        nameUser.addSubview(seperatorLineReturnPasswordUser)
    }
    
    private func setupConstraint() {
        registrText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(75)
        }
        nameUser.snp.makeConstraints { make in
            make.top.equalTo(registrText.snp.bottom).offset(45)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        emailUser.snp.makeConstraints { make in
            make.top.equalTo(nameUser.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        passwordUser.snp.makeConstraints { make in
            make.top.equalTo(emailUser.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        returnPasswordUser.snp.makeConstraints { make in
            make.top.equalTo(passwordUser.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        seperatorLineNameUser.snp.makeConstraints { make in
            make.left.right.equalTo(nameUser)
            make.bottom.equalTo(nameUser)
            make.height.equalTo(2)
        }
        seperatorLineEmailUser.snp.makeConstraints { make in
            make.left.right.equalTo(emailUser)
            make.bottom.equalTo(emailUser)
            make.height.equalTo(2)
        }
        seperatorLinePasswordUser.snp.makeConstraints { make in
            make.left.right.equalTo(passwordUser)
            make.bottom.equalTo(passwordUser)
            make.height.equalTo(2)
        }
        seperatorLineReturnPasswordUser.snp.makeConstraints { make in
            make.left.right.equalTo(returnPasswordUser)
            make.bottom.equalTo(returnPasswordUser)
            make.height.equalTo(2)
        }
        
        textAccount.snp.makeConstraints { make in
            make.top.equalTo(returnPasswordUser.snp.bottom).offset(35)
            make.centerX.equalToSuperview()
        }
        yesAccount.snp.makeConstraints { make in
            make.top.equalTo(textAccount.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        registrButton.snp.makeConstraints { make in
            make.top.equalTo(yesAccount.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
}
