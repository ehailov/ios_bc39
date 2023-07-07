//
//  ObjModel.swift
//  bc
//
//  Created by Evgeny Hailov on 03.07.2023.
//

import Foundation

public struct ObjModel: Identifiable {
    
    public var id: Int
    public var name: String!
    public var work: String!
        
    init(id: Int, data: [String: String]) {
        self.id = id
        self.name = data["name"]
        self.work = data["work"]
    }
    
}
