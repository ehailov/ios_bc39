//
//  ContentView.swift
//  bc
//
//  Created by Evgeny Hailov on 27.06.2023.
//

import SwiftUI

struct NavigationView: View {
    
    @State private var path: [Int]
    @State private var title: String = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            RootView(path: $path, title: $title)
                .navigationTitle($title)
                .navigationDestination(for: Int.self) { _ in
                    LoginView(path: $path)
                }
        }
    }
    
    init() {
        if !DataHelper.share().isLogin() {
            path = [1]
        } else {
            path = []
        }
    }
    
}

struct RootView: View {
    
    @Binding var path: [Int]
    @Binding var title: String
    
    var body: some View {
        TabView {
            NavigationStack(path: $path) {
                FinanseView()
                    .navigationDestination(for: Int.self) { _ in
                        LoginView(path: $path)
                    }
            }
            .onAppear() {
                title = "Финансы"
            }
            .tabItem() {
                Image(systemName: "bitcoinsign")
                Text("Финансы")
            }
            
            NavigationStack(path: $path) {
                JurnalView()
                    .navigationDestination(for: Int.self) { _ in
                        LoginView(path: $path)
                    }
            }
            .onAppear() {
                title = "Журнал"
            }
            .tabItem() {
                Image(systemName: "list.bullet.clipboard")
                Text("Журнал")
            }
            
            NavigationStack(path: $path) {
                FileView()
                    .navigationDestination(for: Int.self) { _ in
                        LoginView(path: $path)
                    }
            }
            .onAppear() {
                title = "Файлы"
            }
            .tabItem() {
                Image(systemName: "folder")
                Text("Файлы")
            }
            
            NavigationStack(path: $path) {
                ProfileVIew(path: $path)
                    .navigationDestination(for: Int.self) { _ in
                        LoginView(path: $path)
                    }
            }
            .onAppear() {
                title = "Профиль"
            }
            .tabItem() {
                Image(systemName: "person")
                Text("Профиль")
            }
        }.onAppear() {
            DataHelper.share().getData()
        }
    }
    
}

//#Preview {
//   MainView(model: model)
//}
