//
//  PickerModel.swift
//  bc
//
//  Created by Evgeny Hailov on 11.07.2023.
//

import Foundation

struct PickerModel: Identifiable {
    
    var id: Int
    var name: String
    
    init(id: Int, value: [String: String] ) {
        self.id = id
        self.name = value["name"] ?? ""
    }
    
    public static func getPickerModel(_ data: Any) -> [String] {
        var objects: [String] = []
        for item in data as! [[String: Any]] {
            let val = PickerModel(id: item["pk"] as! Int, value: item["fields"] as! [String: String])
            objects.append(val.name)
        }
        return objects
    }
}


