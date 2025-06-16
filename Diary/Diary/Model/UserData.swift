//
//  UserData.swift
//  Diary
//
//  Created by Дмитрий Забиякин on 13.06.2025.
//

import Foundation

struct UserData: Identifiable {
    var id: String = UUID().uuidString
    let email: String
    let password: String
    var name: String?
}
