//
//  NumModel.swift
//  bc
//
//  Created by Evgeny Hailov on 03.07.2023.
//

import Foundation

public struct NumModel: Identifiable {
   
    public var id: Int
    public var work: String!
    public var name: String!
    
    init(id: Int, data: [String: String]) {
        self.id = id
        self.work = data["work"]
        self.name = data["name"]
    }
}
