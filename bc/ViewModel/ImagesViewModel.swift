//
//  ImagesViewModel.swift
//  bc
//
//  Created by Evgeny Hailov on 17.07.2023.
//

import Foundation
import SwiftUI

public class ImagesViewModel: ObservableObject {
    
    @Published var images: [String]
    @Published var sharedImages: [Any] = []
    @Published var isSharedSheet: Bool = false
    @Binding var isPresented: Bool
    
    init(model: ImageModel, isPresented: Binding<Bool>) {
        self.images = model.getImages()
        _isPresented = isPresented
    }
    
    public func getUrl(_ file: String) -> URL {
        let string = String(format: "%@/%@", loadImageUrl, file)
        return URL(string: string)!
    }
    
 
}
