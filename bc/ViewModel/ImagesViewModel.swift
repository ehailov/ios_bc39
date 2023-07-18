//
//  ImagesViewModel.swift
//  bc
//
//  Created by Evgeny Hailov on 17.07.2023.
//

import Foundation
import SwiftUI

public class ImagesViewModel: ObservableObject {
    
    @Published public var images: [String]
    
    init(model: ImageModel) {
        self.images = model.getImages()
    }
    
}
