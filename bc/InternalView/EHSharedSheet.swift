//
//  EHSharedSheet.swift
//  bc
//
//  Created by Evgeny Hailov on 18.07.2023.
//

import SwiftUI

struct EHSharedSheet: UIViewControllerRepresentable {
    
    var items: [Any]
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
}
