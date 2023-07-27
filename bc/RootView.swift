//
//  RootView.swift
//  bc
//
//  Created by Evgeny Hailov on 27.06.2023.
//

import SwiftUI

struct RootView: View {
    
    @State private var path: [Int]
    @State private var selected: Int = 0
    
    var body: some View {
        NavigationStack(path: $path) {
            TabView(selection: $selected) {
                
                FinanсeView(path: $path)
                    .tabItem() {
                        Image(systemName: "bitcoinsign")
                        Text(LocalizedStringKey("Finance"))
                    }
                    .tag(0)
                    
                JornalView(path: $path)
                    .tabItem() {
                        Image(systemName: "list.bullet.clipboard")
                        Text(LocalizedStringKey("Journal"))
                    }
                    .tag(1)
                    
                FileView(path: $path)
                    .tabItem() {
                        Image(systemName: "folder")
                        Text(LocalizedStringKey("Files"))
                    }
                    .tag(2)
                    
                ProfileVIew(path: $path)
                    .tabItem() {
                        Image(systemName: "person")
                        Text(LocalizedStringKey("Profile"))
                    }
                    .tag(3)
            }
            .navigationDestination(for: Int.self) { id in
                switch id {
                case 2:
                    AddFinanceView(path: $path)
                case 3:
                    CashView()
                case 4:
                    AddJurnalView(path: $path)
                case 5:
                    AddFileView(path: $path)
                case 6:
                    SettingView()
                default:
                    LoginView(path: $path)
                }
            }
        }
    }
    
    init() {
        if !EHDataLayer.share().isLogin() {
            path = [1]
        } else {
            path = []
            EHDataLayer.share().getData()
        }
    }
}
