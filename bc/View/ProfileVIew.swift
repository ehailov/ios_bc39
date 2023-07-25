//
//  ProfileVIew.swift
//  bc
//
//  Created by Evgeny Hailov on 29.06.2023.
//

import SwiftUI

struct ProfileVIew: View {
    
    @ObservedObject var model: ProfileVIewModel = ProfileVIewModel()
    @Binding var path: [Int]
    
    var body: some View {
        if model.isProgressBar {
            ProgressView()
        } else {
            List {
                Section {
                    LabeledContent("firstName", value: model.profile.firstName)
                    LabeledContent("lastName", value: model.profile.lastName)
                    LabeledContent("Email:", value: model.profile.username)
                }
                Section("staffStructure") {
                    if model.users == nil || model.users!.isEmpty {
                        Text("noData").foregroundColor(.primary)
                    } else {
                        ForEach(model.users!) { data in
                            UserViev(data: data)
                        }
                    }
                }
                Section("objects") {
                    if model.objs == nil || model.objs!.isEmpty {
                        Text("noData").foregroundColor(.primary)
                    } else {
                        ForEach(model.objs!) { data in
                            ObjViev(data: data)
                        }
                    }
                }
                Section("agreements") {
                    if model.nums == nil || model.nums!.isEmpty {
                        Text("noData").foregroundColor(.primary)
                    } else {
                        ForEach(model.nums!) { data in
                            NumViev(data: data)
                        }
                    }
                }
                Section("counterparties") {
                    if model.accs == nil || model.accs!.isEmpty {
                        Text("noData").foregroundColor(.primary)
                    } else {
                        ForEach(model.accs!) { data in
                            AccViev(data: data)
                        }
                    }
                }
                Section() {
                    Button("exit") {
                        model.logOut {
                            path = [1]
                        }
                    }
                    .buttonStyle(EHRedButton())
                }
                .listRowBackground(Color.clear)
                Section() {
                    Text(model.version)
                        .font(.system(size: 12))
                        .padding(.all)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                }.listRowBackground(Color.clear)
                
            }.refreshable {
                model.updateData()
            }
            
        }
    }
        
}

struct ObjViev: View {
    
    var data: ObjModel
    
    var body: some View {
        Text(data.name)
    }
}

struct AccViev: View {
    
    var data: AccModel
    
    var body: some View {
        VStack {
            LabeledContent("name", value: data.name)
            LabeledContent("passport", value: data.passportData)
            LabeledContent("number", value: data.phoneNumber)
        }
    }
}

struct NumViev: View {
    
    var data: NumModel
    
    var body: some View {
        Text(data.name)
    }
}

struct UserViev: View {
    
    var data: UserModel
    
    var body: some View {
        VStack {
            LabeledContent("email", value: data.username)
            LabeledContent("fullName", value: String(format: "%@ %@", data.firstName, data.lastName))
        }
    }
}
