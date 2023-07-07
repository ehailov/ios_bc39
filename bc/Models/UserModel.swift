//
//  UserModel.swift
//  bc
//
//  Created by Evgeny Hailov on 03.07.2023.
//

import Foundation

public struct UserModel: Identifiable {
    
    public var id: Int
    public var username: String
    public var firstName: String
    public var lastName: String
    public var email: String

    init(id: Int, data: [String : Any]) {
        self.id = id
        self.username = data["username"] as? String ?? "-"
        self.firstName = data["first_name"] as? String ?? "-"
        self.lastName = data["last_name"] as? String ?? "-"
        self.email = data["email"] as? String ?? "-"
    }
    
}
