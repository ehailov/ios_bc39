//
//  LoginView.swift
//  bc
//
//  Created by Evgeny Hailov on 04.07.2023.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var pass: String = ""
    @State private var isAlert: Bool = false
    @State private var showProgressView = false
    @Binding var path: [Int]
    
    var body: some View {
        ZStack {
            if !showProgressView {
                VStack {
                    ScrollView {
                        Image("Logo")
                            .resizable()
                            .frame(maxWidth: 150, maxHeight: 150, alignment: .center)
                        
                        HStack {
                            Image(systemName: "person").foregroundColor(.gray)
                            TextField("Enter your email", text: $email)
                                .textFieldStyle(.roundedBorder)
                                .padding(.trailing)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                        .padding(.all)
                        HStack {
                            Image(systemName: "key").foregroundColor(.gray)
                            SecureField("Enter your password", text: $pass)
                                .textFieldStyle(.roundedBorder)
                                .padding(.trailing)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                        .padding(.all)
                        Button("Enter") {
                            showProgressView.toggle()
                            loggin()
                        }
                        .buttonStyle(EHBlueButton())
                        .padding(.all)
                        .alert(isPresented: $isAlert) {
                            Alert(title: Text("Error"), message: Text("Invalid password or email"))
                        }
                    }
                    Spacer()
                    Text(getVersion())
                        .font(.system(size: 12))
                        .padding(.bottom)
                }
            } else {
                ProgressView().progressViewStyle(.circular)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func loggin() {
        EHDataLayer.share().onLoggin(email, pass: pass) { error in
            if error == nil {
                path = []
                return
            }
            isAlert = true
            showProgressView = false
        }
    }
    
    func getVersion() -> String {
        let version = LocalizedStringKey("Version").stringValue()
        return String(format: "%@: %@", version, Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-")
    }
    
}


