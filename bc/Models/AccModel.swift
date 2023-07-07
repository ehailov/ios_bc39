//
//  AccModel.swift
//  bc
//
//  Created by Evgeny Hailov on 03.07.2023.
//

import Foundation

public struct AccModel: Identifiable {
    
    public var id: Int
    public var name: String!
    public var passportData: String!
    public var phoneNumber: String!
    public var comment: String!
    public var work: String!
    
    init(id: Int, data: [String: String]) {
        self.id = id
        self.name = data["name"] ?? ""
        self.passportData = data["passport_data"] ?? ""
        self.phoneNumber = data["phone_number"] ?? ""
        self.comment = data["comment"] ?? ""
        self.work = data["work"] ?? ""
    }
    
}
