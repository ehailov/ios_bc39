//
//  ContentView.swift
//  bc
//
//  Created by Evgeny Hailov on 27.06.2023.
//

import SwiftUI

let finance = "Finance"
let journal = "Journal"
let files = "Files"
let profile = "Profile"

struct NavigationView: View {
    
    @State private var path: [Int]
    @State private var title: String = ""
    @State private var selected: Int = 0
    
    var body: some View {
        NavigationStack(path: $path) {
            RootView(path: $path, title: $title, selected: $selected)
                .navigationDestination(for: Int.self) { id in
                    switch id {
                    case 2:
                        AddFinanceView(path: $path)
                    case 3:
                        CashView()
                    case 4:
                        AddJurnalView()
                    case 5:
                        AddFileView()
                    case 6:
                        SettingView()
                    default:
                        LoginView(path: $path)
                    }
                }
                .navigationTitle(LocalizedStringKey(title))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Image("Logo2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 18, alignment: .leading)
                    }
                    if title != profile {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                if title == finance {
                                    path = [2]
                                } else if title == journal {
                                    path = [4]
                                } else if title == files {
                                    path = [5]
                                }
                            } label: {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                    }
                    if title == finance {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                path = [3]
                            } label: {
                                Image(systemName: "dollarsign.circle.fill")
                            }
                        }
                    }
                    if title == profile {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                path = [6]
                            } label: {
                                Image(systemName: "slider.horizontal.3")
                            }
                        }
                    }
                }
        }
    }
    
    init() {
        if !EHDataHelper.share().isLogin() {
            path = [1]
        } else {
            path = []
            EHDataHelper.share().getData()
        }
    }
}

struct RootView: View {
    
    @Binding var path: [Int]
    @Binding var title: String
    @Binding var selected: Int
    
    var body: some View {
        TabView(selection: $selected) {
            FinanseView()
                .tabItem() {
                    Image(systemName: "bitcoinsign")
                    Text(LocalizedStringKey(finance))
                }
                .tag(0)
                .onAppear() {
                    title = finance
                }
            JurnalView()
                .tabItem() {
                    Image(systemName: "list.bullet.clipboard")
                    Text(LocalizedStringKey(journal))
                }
                .tag(1)
                .onAppear() {
                    title = journal
                }
            FileView()
                .tabItem() {
                    Image(systemName: "folder")
                    Text(LocalizedStringKey(files))
                }
                .tag(2)
                .onAppear() {
                    title = files
            }
            ProfileVIew(path: $path)
                .tabItem() {
                    Image(systemName: "person")
                    Text(LocalizedStringKey(profile))
                }
                .tag(3)
                .onAppear() {
                    title = profile
                }
        }
    }
}
