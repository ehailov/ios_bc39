//
//  LoginViewModel.swift
//  bc
//
//  Created by Evgeny Hailov on 31.07.2023.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var pass: String = ""
    @Published var isAlert: Bool = false
    @Published var showProgressView = false
    lazy var data = getDataLayer()
    
    func loggin(result: @escaping ()->()) {
        data.onLoggin(email, pass: pass) { error in
            if error == nil {
                result()
                return
            }
            self.isAlert = true
            self.showProgressView = false
        }
    }
    
    func getVersion() -> String {
        let version = LocalizedStringKey("Version").stringValue()
        return String(format: "%@: %@", version, Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-")
    }
}
