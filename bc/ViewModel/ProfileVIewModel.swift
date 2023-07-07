//
//  ProfileVIewModel.swift
//  bc
//
//  Created by Evgeny Hailov on 04.07.2023.
//

import Foundation
import SwiftUI

public class ProfileVIewModel: ObservableObject, BaseViewModel {
    
    @Published public var profile: ProfileModel = ProfileModel()
    @Published public var accs: [AccModel]? = nil
    @Published public var objs: [ObjModel]? = nil
    @Published public var nums: [NumModel]? = nil
    @Published public var users: [UserModel]? = nil
    @Published public var error: NSError?
    
    init() {
        let rx = DataHelper.share().rxData
        rx?.subscribe(onNext: { data in
            self.subscribe(data, error: nil)
        }, onError: { error in
            self.subscribe(nil, error: error as NSError)
        })
    }
    
    internal func reloadView() {
        objectWillChange.send()
    }
    
    internal func subscribe(_ data: DataModel?, error: NSError?) {
        profile = data?.profile ?? ProfileModel()
        accs = data?.acc ?? nil
        nums = data?.num ?? nil
        objs = data?.obj ?? nil
        users = data?.users ?? nil
        reloadView()
        self.error = error
    }
    
    public func updateData() {
        profile.clean()
        accs = nil
        nums = nil
        objs = nil
        users = nil
        reloadView()
        DataHelper.share().getData()
    }

}
