//
//  AuthHelper.swift
//  bc
//
//  Created by Evgeny Hailov on 03.07.2023.
//

import Foundation

let sidKey = "sid"
let isRootKey = "isRoot"

public class EHUserDefaults {
    
    public var sid: String! = ""
    public var isRoot: Bool = false
    
    init() {
        self.sid = self.loadString(sidKey)
        self.isRoot = self.loadBool(isRootKey)
    }
    
    public func update(model: AuthModel) {
        self.isRoot = model.root
        self.sid = model.sid
        self.save(sid, key: sidKey)
        self.save(isRoot, key: isRootKey)
    }
    
    public func isLoggin() -> Bool {
        return sid.isEmpty ? false : true
    }
    
    public func logOut() {
        self.isRoot = false
        self.sid = ""
        self.remove(sidKey)
        self.remove(isRootKey)
    }
    
    //MARK: - Private metods
    private func loadBool(_ key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key) ?? false
    }
    
    private func loadString(_ key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
    
    private func save(_ value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    private func remove(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
