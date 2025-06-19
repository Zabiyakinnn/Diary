//
//  PasswordMatch.swift
//  Diary
//
//  Created by Дмитрий Забиякин on 18.06.2025.
//

import Foundation

// обработка ошибки с введеным email при регистрации
enum EmailVarification: Error {
    case invalidEmail // некоректный
    case emailAlreadyInUse // данный email уже используется
    case networkError // проблемы с сетью
    case otherError // остальные ошибки
}

// обработка ошибок с паролем при регистрации
enum PasswordMatchResult {
    case done // успех
    case misDone // пароли не совпадают
    case toShort // короткий пароль
    case empty // остальное
}
