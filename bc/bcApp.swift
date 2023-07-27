//
//  bcApp.swift
//  bc
//
//  Created by Evgeny Hailov on 27.06.2023.
//

import SwiftUI

@main
struct bcApp: App {
    
    @State private var showBcView: Bool = false
    @State private var helloString: String = ""
    @State private var version: String = ""
    
    var body: some Scene {
        
        WindowGroup {
            
            ZStack {
                if self.showBcView {
                    RootView()
                } else {
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        HStack {
                            Text(helloString)
                                .font(.title)
                                .foregroundStyle(.white)
                        }
                        Spacer()
                        Text(version)
                            .font(.system(size: 12))
                            .padding(.bottom)
                            .foregroundColor(.white)
                    }
                    
                }
            }
            
            .onAppear {
                viewDidLoad()
            }
        }
    }
    
    private func viewDidLoad() {
        getHelloString()
        getVersionString()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.showBcView = true
            }
        }
    }
    
    private func getHelloString() {
        let user = UserDefaults.standard.string(forKey: "FirstName") ?? ""
        let hello = LocalizedStringKey("Hello").stringValue()
        helloString = String(format: "%@ %@", hello, user)
    }
    
    private func getVersionString() {
        let version = LocalizedStringKey("Version").stringValue()
        self.version = String(format: "%@: %@", version, Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-")
    }
}
