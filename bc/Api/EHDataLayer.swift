//
//  EHDataLayer.swift
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
    
    public var rxData: BehaviorSubject<DataModel>!
    
    //MARK: - DI property
    private var httpConnection: EHHttpConnection!
    private var user: EHUserDefaults!
    private var model: DataModel!
    private var logger: EHLogger!
    private var dispacher: EHDispacher!
    
    init(user: EHUserDefaults, model: DataModel, httpConnection: EHHttpConnection, logger: EHLogger, dispacher: EHDispacher) {
        self.dispacher = dispacher
        self.user = user
        self.model = model
        self.httpConnection = httpConnection
        self.logger = logger
        self.rxData = BehaviorSubject<DataModel>(value: self.model)
    }
    
    public func getRx() -> BehaviorSubject<DataModel> {
        return rxData
    }
    
    public func isLogin() -> Bool {
        return user.isLoggin()
    }
    
    private func getUrl(_ address: String) -> String {
        return String(format: "%@/%@", url, address)
    }
}

//MARK: - Вata management
extension EHDataLayer {
    
    public func getData() {
        if user.isLoggin() {
            self.dispacher.global {
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
        httpConnection.execute(getUrl("finanse/"), parameters: ["sid": user.sid], method: "GET") { data, error in
            self.dispacher.main {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setFinanse(data: data)
                self.rxData.onNext(self.model)
                self.logger.verbose("getFinanse()", error: error)
            }
        }
    }
    
    private func getJurnal() {
        httpConnection.execute(getUrl("jurnal/"), parameters: ["sid": user.sid], method: "GET") { data, error in
            self.dispacher.main {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setJurnal(data: data)
                self.rxData.onNext(self.model)
                self.logger.verbose("getJurnal()", error: error)
            }
        }
    }
    
    private func getFile() {
        httpConnection.execute(getUrl("file/"), parameters: ["sid": user.sid], method: "GET") { data, error in
            self.dispacher.main {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setFile(data: data)
                self.rxData.onNext(self.model)
                self.logger.verbose("getFile()", error: error)
            }
        }
    }
    
    private func getProfile() {
        httpConnection.execute(getUrl("profile/"), parameters: ["sid": user.sid], method: "GET") { data, error in
            self.dispacher.main {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setProfile(data: data)
                self.rxData.onNext(self.model)
                self.logger.verbose("getProfile()", error: error)
            }
        }
    }
}

//MARK: - References
extension EHDataLayer {
    
    private func getNum() {
        self.dispacher.global { [self] in
            httpConnection.execute(getUrl("num/"), parameters: ["sid": user.sid], method: "GET") { data, error in
                self.dispacher.main {
                    if error != nil {
                        self.rxData.onError(error!)
                        return
                    }
                    self.model.setNum(data: data)
                    self.rxData.onNext(self.model)
                    self.logger.verbose("getNum()", error: error)
                }
            }
        }
    }
    
    private func getAcc() {
        self.dispacher.global { [self] in
            httpConnection.execute(getUrl("acc/"), parameters: ["sid": user.sid], method: "GET") { data, error in
                self.dispacher.main {
                    if error != nil {
                        self.rxData.onError(error!)
                        return
                    }
                    self.model.setAcc(data: data)
                    self.rxData.onNext(self.model)
                    self.logger.verbose("getAcc()", error: error)
                }
            }
        }
    }
    
    private func getObj() {
        self.dispacher.global { [self] in
            httpConnection.execute(getUrl("obj/"), parameters: ["sid": user.sid], method: "GET") { data, error in
                self.dispacher.main {
                    if error != nil {
                        self.rxData.onError(error!)
                        return
                    }
                    self.model.setObj(data: data)
                    self.rxData.onNext(self.model)
                    self.logger.verbose("getObj()", error: error)
                }
            }
        }
    }
    
    private func getUsers() {
        self.dispacher.global { [self] in
            let address = String(format: "%@/staff/", url)
            httpConnection.execute(address, parameters: ["sid": user.sid], method: "GET") { data, error in
                self.dispacher.main {
                    if error != nil {
                        self.rxData.onError(error!)
                        return
                    }
                    self.model.setUsers(data: data)
                    self.rxData.onNext(self.model)
                    self.logger.verbose("getUsers()", error: error)
                }
            }
        }
    }
    
    public func getArticle(result: @escaping PickerResult) {
        self.dispacher.global { [self] in
            let address = String(format: "%@/article/", url)
            httpConnection.execute(address, parameters: ["sid": user.sid], method: "GET") { data, error in
                self.dispacher.main {
                    if error != nil {
                        result(nil)
                        return
                    }
                    result(PickerModel.getPickerModel(data!))
                }
            }
        }
    }
    
    public func getObject(result: @escaping PickerResult) {
        self.dispacher.global { [self] in
            let address = String(format: "%@/objects/", url)
            httpConnection.execute(address, parameters: ["sid": user.sid], method: "GET") { data, error in
                self.dispacher.main {
                    if error != nil {
                        result(nil)
                        return
                    }
                    result(PickerModel.getPickerModel(data!))
                }
            }
        }
    }
    
    public func getCounterparty(result: @escaping PickerResult) {
        self.dispacher.global { [self] in
            let address = String(format: "%@/accoun/", url)
            httpConnection.execute(address, parameters: ["sid": user.sid], method: "GET") { data, error in
                self.dispacher.main {
                    if error != nil {
                        result(nil)
                        return
                    }
                    result(PickerModel.getPickerModel(data!))
                }
            }
        }
    }
    
    public func getContractNumber(result: @escaping PickerResult) {
        self.dispacher.global { [self] in
            let address = String(format: "%@/number/", url)
            httpConnection.execute(address, parameters: ["sid": user.sid], method: "GET") { data, error in
                self.dispacher.main {
                    if error != nil {
                        result(nil)
                        return
                    }
                    result(PickerModel.getPickerModel(data!))
                }
            }
        }
    }
    
}

//MARK: - Save data
extension EHDataLayer {
    
    public func setFinanse(parameters: [String : Any], result: @escaping SaveResult) {
        self.dispacher.global { [self] in
            let address = String(format: "%@/finanse/save/", url)
            var parameters = parameters
            parameters["sid"] = user.sid
            httpConnection.upload(address, parameters: parameters) { data, error in
                let data = data as? [String: String] ?? nil
                self.dispacher.main {
                    result(data, error)
                }
            }
        }
    }
    
    public func setComleted(id: String, result: @escaping SaveResult) {
        self.dispacher.global { [self] in
            let address = String(format: "%@/save/completed/", url)
            httpConnection.execute(address, parameters: ["id": id], method: "GET") { _, error in
                self.dispacher.main {
                    result(nil, error)
                }
            }
        }
    }
    
    public func setCash(parameters: [String : String], comleted: Bool, result: @escaping CashResult) {
        self.dispacher.global { [self] in
            let address = comleted == true ? String(format: "%@/kassa/completed/", url) : String(format: "%@/kassa/", url)
            var parameters = parameters
            parameters["sid"] = user.sid
            httpConnection.execute(address, parameters: parameters, method: "POST") { data, error in
                self.dispacher.main {
                    result(data as? [String : Any], error)
                }
            }
        }
    }
    
    public func setJurnal(parameters: [String : Any], result: @escaping SaveResult) {
        self.dispacher.global { [self] in
            let address = String(format: "%@/jurnal/save/", url)
            var parameters = parameters
            parameters["sid"] = user.sid
            httpConnection.upload(address, parameters: parameters) { data, error in
                let data = data as? [String: String] ?? nil
                self.dispacher.main {
                    result(data, error)
                }
            }
        }
    }
    
    public func setFile(parameters: [String : Any], result: @escaping SaveResult) {
        self.dispacher.global { [self] in
            let address = String(format: "%@/file/save/", url)
            var parameters = parameters
            parameters["sid"] = user.sid
            httpConnection.upload(address, parameters: parameters) { data, error in
                let data = data as? [String: String] ?? nil
                self.dispacher.main {
                    result(data, error)
                }
            }
        }
    }
}

//MARK: - Registration
extension EHDataLayer {
    public func onLoggin(_ email: String, pass: String, logginResult: @escaping LogginResult) {
        self.dispacher.global { [self] in
            let parameters = ["login": email, "password": pass, "device_token": "-", "fsm_token": "-"]
            httpConnection.execute(getUrl("auth/login/"), parameters: parameters, method: "POST") { [self] result, error in
                self.dispacher.main {
                    if error == nil {
                        let data = result as! [String: Any]
                        let model = AuthModel(root: data["root"] as! Bool, sid: data["sid"] as! String, error: data["error"] as! String, mqtt: data["mqtt"] as! Bool)
                        user.update(model: model)
                        getData()
                    }
                    logginResult(error)
                }
            }
        }
    }
    
    public func onLogOut(result: @escaping () -> ()) {
        model.clearAll()
        user.logOut()
        result()
    }
}
