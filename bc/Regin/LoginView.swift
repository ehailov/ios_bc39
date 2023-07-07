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
                            TextField("Введите ваш email", text: $email)
                                .textFieldStyle(.roundedBorder)
                                .padding(.trailing)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                        .padding(.all)
                        HStack {
                            Image(systemName: "key").foregroundColor(.gray)
                            SecureField("Введите ваш пароль", text: $pass)
                                .textFieldStyle(.roundedBorder)
                                .padding(.trailing)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                        .padding(.all)
                        Button("Войти") {
                            showProgressView.toggle()
                            loggin()
                        }
                        .buttonStyle(BlueButton())
                        .padding(.all)
                        .alert(isPresented: $isAlert) {
                            Alert(title: Text("Ошибка:"), message: Text("Неверный пароль или email!"))
                        }
                    }
                    Spacer()
                    Text(String(format: "Версия: %@", Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-"))
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
        DataHelper.share().onLoggin(email, pass: pass) { error in
            if error == nil {
                path = []
                return
            }
            isAlert = true
            showProgressView = false
        }
    }
    
}


