//
//  ProfileModel.swift
//  bc
//
//  Created by Evgeny Hailov on 03.07.2023.
//

import Foundation

public struct ProfileModel {
    
    public var username: String!
    public var firstName: String!
    public var email: String!
    public var lastName: String!
    
    init() {
        self.username = "-"
        self.firstName = "-"
        self.email = "-"
        self.lastName = "-"
    }
    
    public mutating func update(data: [String: String]) {
        self.username = data["username"] ?? ""
        self.firstName = data["first_name"] ?? ""
        self.email = data["email"] ?? ""
        self.lastName = data["last_name"] ?? ""
        saveFirstName(firstName)
    }
    
    private func saveFirstName(_ name: String) {
        UserDefaults.standard.set(name, forKey: "FirstName")
    }
    
    private func loadFirstName() -> String {
        return UserDefaults.standard.string(forKey: "FirstName") ?? ""
    }
    
    public mutating func clean() {
        UserDefaults.standard.removeObject(forKey: "FirstName")
        self.username = "-"
        self.firstName = "-"
        self.email = "-"
        self.lastName = "-"
    }
    
}
