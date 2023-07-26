//
//  EHDispacher.swift
//  bc
//
//  Created by Evgeny Hailov on 26.07.2023.
//

import Foundation

public class EHDispacher {
    
    static public func global(callback: @escaping ()->()) {
        DispatchQueue.global(qos: .userInitiated).async {
            callback()
        }
    }
    
    static public func main(callback: @escaping ()->()) {
        DispatchQueue.main.async {
            callback()
        }
    }
    
}
