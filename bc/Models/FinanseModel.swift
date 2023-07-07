//
//  FinanseModel.swift
//  bc
//
//  Created by Evgeny Hailov on 29.06.2023.
//

import Foundation

public struct FinanseModel: Identifiable {
    public var id: Int
    public var accoun: String
    public var article: String
    public var completed: Bool
    public var date: String
    public var dohod: Bool
    public var image: String
    public var objects: String
    public var kassa: String
    public var number: String
    public var sum: String
    public var typeOfWork: String
    public var work: String
    public var text: String
   
    init(id: Int, data: [String: Any]) {
        self.id = id
        self.accoun = data["accoun"] as! String
        self.article = data["article"] as! String
        self.completed = data["completed"] as! Bool
        self.date = Utils.dateTimeFormat(data["data"] as! String)
        self.dohod = data["dohod"] as! Bool
        self.image = data["file"] as! String
        self.objects = data["id_objects"] as! String
        self.kassa = data["kassa"] as! String
        self.number = data["number"] as! String
        self.sum = data["sum"] as! String
        self.typeOfWork = data["type_of_work"] as? String ?? ""
        self.work = data["work"] as! String
        self.text = data["text"] as! String
    }
    
}
