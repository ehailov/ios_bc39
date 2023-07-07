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
    @State private var text: String = ""
    
    var body: some Scene {
        
        WindowGroup {
            
            ZStack {
                if self.showBcView {
                    NavigationView()
                } else {
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                    
                    Text(String(format: "Привет %@!", text)).font(.title).foregroundStyle(.white)
                }
            }
            .onAppear {
                viewDidLoad()
            }
        }
    }
    
    func viewDidLoad() {
        text = UserDefaults.standard.string(forKey: "FirstName") ?? ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.showBcView = true
            }
        }
    }

}
