//
//  RegistrViewModel.swift
//  Diary
//
//  Created by Дмитрий Забиякин on 30.05.2025.
//

import Foundation

final class RegistrViewModel {
    
    private let service = AuthService()
    
    /// проверка введенного пароля
    /// - Parameters:
    ///   - passwordOne: пароль
    ///   - passwordTwo: повтор пароля
    /// - Returns: результат
    func checkPassword(_ passwordOne: String, _ passwordTwo: String) -> PasswordMatchResult {
        if passwordOne.isEmpty || passwordTwo.isEmpty {
            return .empty
        } else if passwordOne.count < 6 {
            return .toShort
        } else if passwordOne != passwordTwo {
            return .misDone
        } else {
            return .done
        }
    }
    
//    регистрация пользователя
    func registrUser(email: String, password: String, nameUser: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        let user = UserData(email: email, password: password, name: nameUser)
        service.createNewUser(user: user, completion: completion)
    }
}

