//
//  AuthService.swift
//  Diary
//
//  Created by Дмитрий Забиякин on 06.06.2025.
//

import Foundation
import FirebaseAuth
import Firebase


final class AuthService {
    
    /// Регистрация нового пользователя
    /// - Parameters:
    ///   - user: Пользлователь
    ///   - completion: completion
    func createNewUser(user: UserData, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, err in
            guard let self = self else { return }
//            guard err == nil else {
//                print(err!)
//                completion(.failure(err!))
//                return
//            }
            
            if let error = err as? NSError {
                let code = AuthErrorCode.Code(rawValue: error.code)
                
                print("Error-----\(error)")
                
                switch code {
                case .emailAlreadyInUse:
                    print("Email зарегестрирован")
                    completion(.failure(EmailVarification.emailAlreadyInUse))
                    return
                case .invalidEmail:
                    print("Некореткный email")
                    completion(.failure(EmailVarification.invalidEmail))
                    return
                case .networkError:
                    print("Проблемы с сетью")
                    completion(.failure(EmailVarification.networkError))
                    return
                default:
                    print("Другая ошибка регистрации \(error.localizedDescription)")
                    completion(.failure(EmailVarification.otherError))
                    return
                }
            }
            
            result?.user.sendEmailVerification()
            signOut()
            completion(.success(true))

//            save name
//            guard let userId = result?.user.uid else { return }
//            setUserData(user: user, userId: userId) { [weak self] isAdd in
//                if isAdd {
//                    self?.signOut()
//                    completion(.success(true))
//                } else {
//                    return
//                }
//            }
        }
    }
    
    
    /// Сохранение имени пользователя
    /// - Parameters:
    ///   - user: Пользователь
    ///   - userId: UserID
    ///   - completion: completion
    private func setUserData(user: UserData, userId: String, completion: @escaping (Bool) -> Void) {
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .setData(["user": user.name ?? "", "email": user.email]) { err in
                guard err == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    
    
    /// Авторизация пользователя
    /// - Parameters:
    ///   - user: Пользователь
    ///   - completion: completion
    func signIn(user: UserData, completion: @escaping(Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { [weak self] result, err in
            guard let self = self else { return }
            
            if let error = err as? NSError {
                let code = AuthErrorCode.Code(rawValue: error.code)
                
                switch code {
                case .invalidEmail:
                    print("Неверный формат email")
                    completion(.failure(SignInError.invalidEmailFormat))
                    return
                case .wrongPassword, .invalidCredential:
                    print("Неверный пароль")
                    completion(.failure(SignInError.wrongPassword))
                    return
                case .appNotVerified:
                    print("Пользователь не прошел верефикацию")
                    completion(.failure(SignInError.notVerified))
                    return
                default:
                    print("Другая ошибка: \(code?.rawValue ?? -1) - \(error.localizedDescription)")
                    return
                }
            }
            
            guard let user = result?.user else {
                //пользователь не найден
                completion(.failure(SignInError.wrongPassword))
                print("Error email and password")
                return
            }
            
            if !user.isEmailVerified {
                //пользователь не верефецирован
                completion(.failure(SignInError.notVerified))
                print("Error not verified")
                result?.user.sendEmailVerification() // повторное письмо верефикации пользователя
                signOut()
                return
            }
            
            completion(.success(true))
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    func isLogin() -> Bool {
        if let _ = Auth.auth().currentUser {
            return true
        }
        return false
    }
}
