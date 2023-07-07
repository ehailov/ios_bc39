//
//  DataModel.swift
//  bc
//
//  Created by Evgeny Hailov on 03.07.2023.
//

import Foundation

public class DataModel {
    
    public var finanse: [FinanseModel]?
    public var jurnal: [JurnalModel]?
    public var file: [FileModel]?
    public var profile: ProfileModel
    public var num: [NumModel]?
    public var acc: [AccModel]?
    public var obj: [ObjModel]?
    public var users: [UserModel]?
    
    init() {
        self.finanse = nil
        self.jurnal == nil
        self.file = nil
        self.profile = ProfileModel()
        self.num = nil
        self.acc = nil
        self.obj = nil
        self.users = nil
    }
    
    public func clearAll() {
        finanse = nil
        jurnal = nil
        file = nil
        num = nil
        acc = nil
        obj = nil
        users = nil
        profile.clean()
    }
    
    public func setFinanse(data: Any?) {
        if data == nil {
            return
        }
        finanse = []
        for item in data as! [[String: Any]] {
            finanse!.append(FinanseModel(id: item["pk"] as! Int, data: item["fields"] as! [String : Any]))
        }
    }
    
    public func setJurnal(data: Any?) {
        if data == nil {
            return
        }
        jurnal = []
        for item in data as! [[String: Any]] {
            jurnal!.append(JurnalModel(id: item["pk"] as! Int, data: item["fields"] as! [String : String]))
        }
    }
    
    public func setFile(data: Any?) {
        if data == nil {
            return
        }
        file = []
        for item in data as! [[String: Any]] {
            file!.append(FileModel(id: item["pk"] as! Int, data: item["fields"] as! [String : String]))
        }
    }
    
    public func setProfile(data: Any?) {
        if data == nil {
            profile = ProfileModel()
            return
        }
        profile.update(data: data as! [String : String])
    }
    
    public func setNum(data: Any?) {
        if data == nil {
            return
        }
        num = []
        for item in data as! [[String: Any]] {
            num!.append(NumModel(id: item["pk"] as! Int, data: item["fields"] as! [String : String]))
        }
    }
    
    public func setAcc(data: Any?) {
        if data == nil {
            return
        }
        acc = []
        for item in data as! [[String: Any]] {
            acc!.append(AccModel(id: item["pk"] as! Int, data: item["fields"] as! [String : String]))
        }
    }
    
    public func setObj(data: Any?) {
        if data == nil {
            return
        }
        obj = []
        for item in data as! [[String: Any]] {
            self.obj!.append(ObjModel(id: item["pk"] as! Int, data: item["fields"] as! [String : String]))
        }
    }
    
    public func setUsers(data: Any?) {
        if data == nil {
            return
        }
        users = []
        for item in data as! [[String: Any]] {
            users!.append(UserModel(id: item["pk"] as! Int, data: item["fields"] as! [String : Any]))
        }
    }
    
}
