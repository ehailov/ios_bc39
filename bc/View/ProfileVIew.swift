//
//  ProfileVIew.swift
//  bc
//
//  Created by Evgeny Hailov on 29.06.2023.
//

import SwiftUI

struct ProfileVIew: View {
    
    @Binding var path: [Int]
    @ObservedObject var model = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
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
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ProfileCustomBarItem(path: $path)
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

struct ProfileCustomBarItem: ToolbarContent {
    
    @Binding var path: [Int]
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Image("Logo2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 18, alignment: .leading)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                path = [6]
            } label: {
                Image(systemName: "slider.horizontal.3")
            }
        }
    }
}
