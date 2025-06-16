//
//  AuthViewModel.swift
//  Diary
//
//  Created by Дмитрий Забиякин on 13.06.2025.
//

import Foundation

final class AuthViewModel {
    
    private let service = AuthService()
    
    func authUser(email: String, password: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        let user = UserData(email: email, password: password)
        service.signIn(user: user, completion: completion)
    }
}
