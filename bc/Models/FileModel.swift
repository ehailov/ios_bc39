//
//  FileModel.swift
//  bc
//
//  Created by Evgeny Hailov on 03.07.2023.
//

import Foundation

public struct FileModel: Identifiable {
    
    public var id: Int
    public var name: String!
    public var type: String!
    public var file: String!
    public var work: String!
    public var obj: String!
    
    init(id: Int, data: [String: String]) {
        self.id = id
        self.name = data["name"] ?? ""
        self.type = data["type"] ?? ""
        self.file = data["file"] ?? ""
        self.work = data["work"] ?? ""
        self.obj = data["obj"] ?? ""
    }
}
