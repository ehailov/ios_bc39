//
//  JurnalModel.swift
//  bc
//
//  Created by Evgeny Hailov on 03.07.2023.
//

import Foundation

public struct JurnalModel: Identifiable {
    
    public var id: Int
    public var work: String
    public var obj: String
    public var date: String
    public var typeOfWork: String
    public var worker: String
    public var file0: String
    public var file1: String
    public var file2: String
    public var file3: String
    public var file4: String
    public var file5: String
    public var file6: String
    public var file7: String
    public var file8: String
    public var file9: String
    
    init(id: Int, data: [String: String]) {
        self.id = id
        self.work = data["work"] ?? ""
        self.obj = data["obj"] ?? ""
        self.date = Utils.dateFormat(data["date"] ?? "")
        self.typeOfWork = data["text"] ?? ""
        self.worker = data["worker"] ?? ""
        self.file0 = data["file"] ?? ""
        self.file1 = data["file1"] ?? ""
        self.file2 = data["file2"] ?? ""
        self.file3 = data["file3"] ?? ""
        self.file4 = data["file4"] ?? ""
        self.file5 = data["file5"] ?? ""
        self.file6 = data["file6"] ?? ""
        self.file7 = data["file7"] ?? ""
        self.file8 = data["file8"] ?? ""
        self.file9 = data["file9"] ?? ""
    }
}
