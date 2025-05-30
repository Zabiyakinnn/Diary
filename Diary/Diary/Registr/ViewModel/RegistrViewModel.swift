//
//  RegistrViewModel.swift
//  Diary
//
//  Created by Дмитрий Забиякин on 30.05.2025.
//

import Foundation

final class RegistrViewModel {
    
    
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
}

enum PasswordMatchResult {
    case done // успех
    case misDone // пароли не совпадают
    case toShort // короткий пароль
    case empty // остальное
}
