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
        List {
            Section {
                LabeledContent("Ф.И.О:", value: String(format: "%@ %@", model.profile.firstName, model.profile.lastName))
                LabeledContent("Email:", value: model.profile.username)
            }
            Section("Штатная структура:") {
                if model.users == nil || model.users!.isEmpty {
                    Text("Нет данных").foregroundColor(.primary)
                } else {
                    ForEach(model.users!) { data in
                        UserViev(data: data)
                    }
                }
            }
            Section("Объекты:") {
                if model.objs == nil || model.objs!.isEmpty {
                    Text("Нет данных").foregroundColor(.primary)
                } else {
                    ForEach(model.objs!) { data in
                        ObjViev(data: data)
                    }
                }
            }
            Section("Договора:") {
                if model.nums == nil || model.nums!.isEmpty {
                    Text("Нет данных").foregroundColor(.primary)
                } else {
                    ForEach(model.nums!) { data in
                        NumViev(data: data)
                    }
                }
            }
            Section("Контрагенты:") {
                if model.accs == nil || model.accs!.isEmpty {
                    Text("Нет данных").foregroundColor(.primary)
                } else {
                    ForEach(model.accs!) { data in
                        AccViev(data: data)
                    }
                }
            }
            Section() {
                Button("Выйти") {
                    logOut()
                }
                .buttonStyle(RedButton())
            }
            .listRowBackground(Color.clear)
            Section() {
                Text(String(format: "Версия: %@", Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-"))
                    .font(.system(size: 12))
                    .padding(.all)
                    .frame(maxWidth: .infinity, alignment: .center)
                
            }.listRowBackground(Color.clear)
            
        }.refreshable {
            model.updateData()
        }
        
    }
    
    func logOut() {
        DataHelper.share().onLogOut()
        path = [1]
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
            LabeledContent("Наименование:", value: data.name)
            LabeledContent("Паспорт:", value: data.passportData)
            LabeledContent("Номер:", value: data.phoneNumber)
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
            LabeledContent("Логин:", value: data.username)
            LabeledContent("Ф.И.О.:", value: String(format: "%@ %@", data.firstName, data.lastName))
        }
    }
}
