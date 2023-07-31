//
//  EHDispacher.swift
//  bc
//
//  Created by Evgeny Hailov on 26.07.2023.
//

import Foundation

public class EHDispacher {
    
    public func global(callback: @escaping ()->()) {
        DispatchQueue.global(qos: .userInitiated).async {
            callback()
        }
    }
    
    public func main(callback: @escaping ()->()) {
        DispatchQueue.main.async {
            callback()
        }
    }
    
}
