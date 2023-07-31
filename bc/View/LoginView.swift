//
//  LoginView.swift
//  bc
//
//  Created by Evgeny Hailov on 04.07.2023.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var model = LoginViewModel()
    @Binding var path: [Int]
    
    var body: some View {
        ZStack {
            if !model.showProgressView {
                VStack {
                    ScrollView {
                        Image("Logo")
                            .resizable()
                            .frame(maxWidth: 150, maxHeight: 150, alignment: .center)
                        
                        HStack {
                            Image(systemName: "person").foregroundColor(.gray)
                            TextField("Enter your email", text: $model.email)
                                .textFieldStyle(.roundedBorder)
                                .padding(.trailing)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                        .padding(.all)
                        HStack {
                            Image(systemName: "key").foregroundColor(.gray)
                            SecureField("Enter your password", text: $model.pass)
                                .textFieldStyle(.roundedBorder)
                                .padding(.trailing)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                        .padding(.all)
                        Button("Enter") {
                            model.showProgressView.toggle()
                            model.loggin {
                                path = []
                            }
                        }
                        .buttonStyle(EHBlueButton())
                        .padding(.all)
                        .alert(isPresented: $model.isAlert) {
                            Alert(title: Text("Error"), message: Text("Invalid password or email"))
                        }
                    }
                    Spacer()
                    Text(model.getVersion())
                        .font(.system(size: 12))
                        .padding(.bottom)
                }
            } else {
                ProgressView().progressViewStyle(.circular)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    
    
}


