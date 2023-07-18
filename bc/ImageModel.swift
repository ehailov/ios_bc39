//
//  ImageModel.swift
//  bc
//
//  Created by Evgeny Hailov on 18.07.2023.
//

import Foundation

public protocol ImageModel {
    
    func getImagesFromJurnal() -> [String]
    
    func getImageModelForFinace() -> [String]
        
}
