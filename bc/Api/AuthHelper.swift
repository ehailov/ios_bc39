//
//  AuthHelper.swift
//  bc
//
//  Created by Evgeny Hailov on 03.07.2023.
//

import Foundation

public class AuthHelper {
    
    public var sid: String!
    public var isRoot: Bool
    
    init() {
        self.sid = UserDefaults.standard.string(forKey: "sid") ?? ""
        self.isRoot = UserDefaults.standard.bool(forKey: "isRoot") ?? false
    }
    
    public func update(model: AuthModel) {
        self.isRoot = model.root
        self.sid = model.sid
        UserDefaults.standard.set(self.sid, forKey: "sid")
        UserDefaults.standard.set(self.isRoot, forKey: "isRoot")
    }
    
    public func isLoggin() -> Bool {
        return sid.isEmpty ? false : true
    }
    
    public func logOut() {
        self.isRoot = false
        self.sid = ""
        UserDefaults.standard.removeObject(forKey: "sid")
        UserDefaults.standard.removeObject(forKey: "isRoot")
    }
}
