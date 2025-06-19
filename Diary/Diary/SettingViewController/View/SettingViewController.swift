//
//  SettingViewController.swift
//  Diary
//
//  Created by Дмитрий Забиякин on 16.06.2025.
//

import UIKit

final class SettingViewController: UIViewController {
    
    private let settingView = SettingView()
    private let viewModel = SettingViewModel()
    
    override func loadView() {
        super.loadView()
        self.view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton()
    }
    
    private func setupButton() {
        settingView.logOutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
    }
    
    @objc private func logOutButtonTapped() {
        viewModel.logOut()
        NotificationCenter.default.post(name: Notification.Name("routeVC"), object: nil, userInfo: ["vc": WindowCase.auth])
    }
}
