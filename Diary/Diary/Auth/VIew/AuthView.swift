//
//  AuthView.swift
//  Diary
//
//  Created by Дмитрий Забиякин on 05.06.2025.
//

import UIKit
import SnapKit

final class AuthView: UIView {
    
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
    
    //    Заголовок авторизация
    private lazy var authText: UILabel = {
        let label = UILabel()
        label.text = "Авторизация"
        label.textColor = UIColor(named: "ColorTextRegistrAuth")
        label.font = UIFont(name: "NTSomic-Bold", size: 27)
        return label
    }()
    
    //    Текст "У вас нет аккаунта?"
    private lazy var textAccount: UILabel = {
        let label = UILabel()
        label.text = "У вас нет аккаунта?"
        label.textColor = UIColor(named: "ColorTextRegistrAuth")
        label.font = UIFont(name: "NTSomic-Medium", size: 15)
        return label
    }()
    
    //    Кнопка для перехода на окно авторизации
    lazy var noAccount: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.setTitle("Зарегистрировать аккаунт", for: .normal)
        button.titleLabel?.font = UIFont(name: "NTSomic-Medium", size: 15)
        button.setTitleColor(UIColor(named: "ColorTextRegistrAuth"), for: .normal)
        return button
    }()
    
    //    Кнопка авторизации
    lazy var enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = UIFont(name: "NTSomic-Medium", size: 22)
        button.setTitleColor(UIColor(named: "ColorTextRegistrAuth"), for: .normal)
        return button
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
        placeholderText.text = "Введите пароль"
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText.text ?? "", attributes: attributes)
        
        let imageView = UIImageView(image: UIImage(systemName: "key.icloud"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "ColorTextRegistrAuth")
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        imageView.frame = CGRect(x: 5, y: 0, width: 25, height: 20)
        containerView.addSubview(imageView)
        
        textField.leftView = containerView
        textField.leftViewMode = .always
        
        textField.rightView = showPassword
        textField.rightViewMode = .always
        
        textField.font = UIFont(name: "NTSomic-Regular", size: 16)
        textField.textColor = UIColor(named: "ColorTextRegistrAuth")
        textField.backgroundColor = .clear
        
        return textField
    }()
    
//    показать пароль
    lazy var showPassword: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = UIColor(named: "ColorTextRegistrAuth")
        button.frame = CGRect(x: 5, y: 0, width: 25, height: 20)
        return button
    }()
    
    //разделительная линия
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
}

//MARK: SetupLayout
extension AuthView {
    private func setupLayout() {
        addSubview(authText)
        addSubview(emailUser)
        addSubview(passwordUser)
        addSubview(textAccount)
        addSubview(enterButton)
        addSubview(noAccount)
        
        emailUser.addSubview(seperatorLineEmailUser)
        passwordUser.addSubview(seperatorLinePasswordUser)
    }
    private func setupConstraint() {
        authText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(75)
        }
        emailUser.snp.makeConstraints { make in
            make.top.equalTo(authText.snp.bottom).offset(45)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        passwordUser.snp.makeConstraints { make in
            make.top.equalTo(emailUser.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(50)
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
        textAccount.snp.makeConstraints { make in
            make.top.equalTo(passwordUser.snp.bottom).offset(35)
            make.centerX.equalToSuperview()
        }
        noAccount.snp.makeConstraints { make in
            make.top.equalTo(textAccount.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(noAccount.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
}
