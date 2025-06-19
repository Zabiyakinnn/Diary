//
//  SettingView.swift
//  Diary
//
//  Created by Дмитрий Забиякин on 16.06.2025.
//

import UIKit
import SnapKit

final class SettingView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.systemBackground
        
        setupLayout()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //выйти из аккаунта
    lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.setTitle("Выйти", for: .normal)
        button.titleLabel?.font = UIFont(name: "NTSomic-Medium", size: 22)
        button.setTitleColor(UIColor.systemRed, for: .normal)
        return button
    }()
}

//MARK: SetupLayout
extension SettingView {
    private func setupLayout() {
        addSubview(logOutButton)
    }
    private func setupConstraint() {
        logOutButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(-40)
            make.height.equalTo(30)
        }
    }
}

