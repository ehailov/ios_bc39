//
//  DataHelper.swift
//  bc
//
//  Created by Evgeny Hailov on 29.06.2023.
//

import Foundation
import RxSwift

let url = "http://bc-24.ru/api"
let loadImageUrl = "http://bc-24.ru/media"
public typealias CashResult = ([String: Any]?, NSError?) -> ()
public typealias SaveResult = ([String: String]?, NSError?) -> ()
public typealias LogginResult = (NSError?) -> ()
public typealias DataResult = () -> ()
public typealias PickerResult = (_ data: [String]?) -> ()

public class EHDataLayer {
    
    static let data = EHDataLayer()
    private var httpConnection: HttpConnection!
    private var auth: EHAuthHelper!
    public var rxData: BehaviorSubject<DataModel>!
    private var model: DataModel!
    
    public static func share() -> EHDataLayer {
        return data
    }
    
    init() {
        self.auth = EHAuthHelper()
        self.model = DataModel()
        self.httpConnection = HttpConnection()
        self.rxData = BehaviorSubject<DataModel>(value: self.model)
    }
    
    public func getRx() -> BehaviorSubject<DataModel> {
        return rxData
    }
    
    public func isLogin() -> Bool {
        return auth.isLoggin()
    }
    
    private func getUrl(_ address: String) -> String {
        return String(format: "%@/%@", url, address)
    }
}

//MARK: - Вata management
extension EHDataLayer {
    
    public func getData() {
        if auth.isLoggin() {
            DispatchQueue.global().async {
                self.getFinanse()
                self.getJurnal()
                self.getFile()
                self.getProfile()
                self.getAcc()
                self.getNum()
                self.getObj()
                self.getUsers()
            }
        }
    }
    
    public func updateData() {
        model.clearAll()
        rxData.onNext(model)
        getData()
    }
}

//MARK: - Getting data
extension EHDataLayer {
    
    private func getFinanse() {
        httpConnection.execute(getUrl("finanse/"), parameters: ["sid": auth.sid], method: "GET") { data, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setFinanse(data: data)
                self.rxData.onNext(self.model)
                EHLogger.verbose("getFinanse()", error)
            }
        }
    }
    
    private func getJurnal() {
        httpConnection.execute(getUrl("jurnal/"), parameters: ["sid": auth.sid], method: "GET") { data, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setJurnal(data: data)
                self.rxData.onNext(self.model)
                EHLogger.verbose("getJurnal()", error)
            }
        }
    }
    
    private func getFile() {
        httpConnection.execute(getUrl("file/"), parameters: ["sid": auth.sid], method: "GET") { data, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setFile(data: data)
                self.rxData.onNext(self.model)
                EHLogger.verbose("getFile()", error)
            }
        }
    }
    
    private func getProfile() {
        httpConnection.execute(getUrl("profile/"), parameters: ["sid": auth.sid], method: "GET") { data, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setProfile(data: data)
                self.rxData.onNext(self.model)
                EHLogger.verbose("getProfile()", error)
            }
        }
    }
}

//MARK: - References
extension EHDataLayer {
    
    private func getNum() {
        httpConnection.execute(getUrl("num/"), parameters: ["sid": auth.sid], method: "GET") { data, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setNum(data: data)
                self.rxData.onNext(self.model)
                EHLogger.verbose("getNum()", error)
            }
        }
    }
    
    private func getAcc() {
        httpConnection.execute(getUrl("acc/"), parameters: ["sid": auth.sid], method: "GET") { data, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setAcc(data: data)
                self.rxData.onNext(self.model)
                EHLogger.verbose("getAcc()", error)
            }
        }
    }
    
    private func getObj() {
        httpConnection.execute(getUrl("obj/"), parameters: ["sid": auth.sid], method: "GET") { data, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setObj(data: data)
                self.rxData.onNext(self.model)
                EHLogger.verbose("getObj()", error)
            }
        }
    }
    
    private func getUsers() {
        let address = String(format: "%@/staff/", url)
        httpConnection.execute(address, parameters: ["sid": auth.sid], method: "GET") { data, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setUsers(data: data)
                self.rxData.onNext(self.model)
                EHLogger.verbose("getUsers()", error)
            }
        }
    }
    
    public func getArticle(result: @escaping PickerResult) {
        let address = String(format: "%@/article/", url)
        httpConnection.execute(address, parameters: ["sid": auth.sid], method: "GET") { data, error in
            if error != nil {
                result(nil)
                return
            }
            result(PickerModel.getPickerModel(data!))
        }
    }
    
    public func getObject(result: @escaping PickerResult) {
        let address = String(format: "%@/objects/", url)
        httpConnection.execute(address, parameters: ["sid": auth.sid], method: "GET") { data, error in
            if error != nil {
                result(nil)
                return
            }
            result(PickerModel.getPickerModel(data!))
        }
    }
    
    public func getCounterparty(result: @escaping PickerResult) {
        let address = String(format: "%@/accoun/", url)
        httpConnection.execute(address, parameters: ["sid": auth.sid], method: "GET") { data, error in
            if error != nil {
                result(nil)
                return
            }
            result(PickerModel.getPickerModel(data!))
        }
    }
    
    public func getContractNumber(result: @escaping PickerResult) {
        let address = String(format: "%@/number/", url)
        httpConnection.execute(address, parameters: ["sid": auth.sid], method: "GET") { data, error in
            if error != nil {
                result(nil)
                return
            }
            result(PickerModel.getPickerModel(data!))
        }
    }
    
}

//MARK: - Save data
extension EHDataLayer {
    
    public func setFinanse(parameters: [String : Any], result: @escaping SaveResult) {
        let address = String(format: "%@/finanse/save/", url)
        var parameters = parameters
        parameters["sid"] = auth.sid
        httpConnection.upload(address, parameters: parameters) { data, error in
            let data = data as? [String: String] ?? nil
            result(data, error)
        }
    }
    
    public func setComleted(id: String, result: @escaping SaveResult) {
        let address = String(format: "%@/save/completed/", url)
        httpConnection.execute(address, parameters: ["id": id], method: "GET") { _, error in
            result(nil, error)
        }
    }
    
    public func setCash(parameters: [String : String], comleted: Bool, result: @escaping CashResult) {
        let address = comleted == true ? String(format: "%@/kassa/completed/", url) : String(format: "%@/kassa/", url)
        var parameters = parameters
        parameters["sid"] = auth.sid
        httpConnection.execute(address, parameters: parameters, method: "POST") { data, error in
            result(data as? [String : Any], error)
        }
    }
    
    public func setJurnal(parameters: [String : Any], result: @escaping SaveResult) {
        let address = String(format: "%@/jurnal/save/", url)
        var parameters = parameters
        parameters["sid"] = auth.sid
        httpConnection.upload(address, parameters: parameters) { data, error in
            let data = data as? [String: String] ?? nil
            result(data, error)
        }
    }
    
    public func setFile(parameters: [String : Any], result: @escaping SaveResult) {
        let address = String(format: "%@/file/save/", url)
        var parameters = parameters
        parameters["sid"] = auth.sid
        httpConnection.upload(address, parameters: parameters) { data, error in
            let data = data as? [String: String] ?? nil
            result(data, error)
        }
    }
    
}

//MARK: - Registration
extension EHDataLayer {
    
    public func onLoggin(_ email: String, pass: String, logginResult: @escaping LogginResult) {
        let parameters = ["login": email, "password": pass, "device_token": "-", "fsm_token": "-"]
        httpConnection.execute(getUrl("auth/login/"), parameters: parameters, method: "POST") { [self] result, error in
            if error == nil {
                let data = result as! [String: Any]
                let model = AuthModel(root: data["root"] as! Bool, sid: data["sid"] as! String, error: data["error"] as! String, mqtt: data["mqtt"] as! Bool)
                auth.update(model: model)
                getData()
            }
            logginResult(error)
        }
    }
    
    public func onLogOut(result: @escaping () -> ()) {
        model.clearAll()
        auth.logOut()
        result()
    }
}
