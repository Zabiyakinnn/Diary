//
//  SettingViewModel.swift
//  Diary
//
//  Created by Дмитрий Забиякин on 16.06.2025.
//

import UIKit

final class SettingViewModel {
    
    private let authService = AuthService()
    
    func logOut() {
        authService.signOut()
    }
}
