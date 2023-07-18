//
//  JurnalModel.swift
//  bc
//
//  Created by Evgeny Hailov on 03.07.2023.
//

import Foundation

public struct JurnalModel: Identifiable, ImageModel {
    
    public var id: Int
    public var work: String
    public var obj: String
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
    public var date: String = "-"
    
    init(id: Int, data: [String: String]) {
        self.id = id
        self.work = data["work"] ?? ""
        self.obj = data["obj"] ?? ""
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
        self.date = getDate(data["date"])
    }
    
    private func getDate(_ string: String?) -> String {
        if string == nil {
            return "-"
        }
        return Utils.dateFrom(string: string!, format: "yyyy-MM-dd") ?? "-"
    }
    
    public func getImages() -> [String] {
        var images: [String] = []
        if !file0.isEmpty {
            images.append(file0)
        }
        if !file1.isEmpty {
            images.append(file1)
        }
        if !file2.isEmpty {
            images.append(file2)
        }
        if !file3.isEmpty {
            images.append(file3)
        }
        if !file4.isEmpty {
            images.append(file4)
        }
        if !file5.isEmpty {
            images.append(file5)
        }
        if !file6.isEmpty {
            images.append(file6)
        }
        if !file7.isEmpty {
            images.append(file7)
        }
        if !file8.isEmpty {
            images.append(file8)
        }
        if !file9.isEmpty {
            images.append(file9)
        }
        return images
    }
   
}
