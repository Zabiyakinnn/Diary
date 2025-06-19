//
//  ErrorAuth.swift
//  Diary
//
//  Created by Дмитрий Забиякин on 17.06.2025.
//

import Foundation

//обработка ошибок при авторизации
enum SignInError: Error {
    case notVerified // пользователь не авторизован
    case wrongPassword // неверный пароль
    case invalidEmailFormat // неверный email
}
