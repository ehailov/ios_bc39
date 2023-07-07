//
//  DataHelper.swift
//  bc
//
//  Created by Evgeny Hailov on 29.06.2023.
//

import Foundation
import RxSwift

let url = "http://bc-24.ru/api"
public typealias LogginResult = (NSError?) -> ()
public typealias DataResult = () -> ()

final public class DataHelper {
    
    static let data = DataHelper()
    private var httpConnection: HttpConnection!
    private var auth: AuthHelper!
    public var rxData: BehaviorSubject<DataModel>!
    private var model: DataModel!
    
    public static func share() -> DataHelper {
        return data
    }
    
    init() {
        self.auth = AuthHelper()
        self.model = DataModel()
        self.httpConnection = HttpConnection()
        self.rxData = BehaviorSubject<DataModel>(value: self.model)
    }
    
    public func getRx() -> BehaviorSubject<DataModel> {
        return rxData
    }
    
    public func onNext(_ data: DataModel) {
        rxData.onNext(data)
    }
    
    public func onLogOut() {
        model.clearAll()
        auth.logOut()
    }
    
    public func isLogin() -> Bool {
        return auth.isLoggin()
    }
    
    public func log(_ text: String, _ error: NSError?) {
        if error != nil {
            NSLog("BC Error: %@ %@", text, error!.localizedDescription)
            return
        }
        NSLog("BC Log: %@ ", text)
    }
    
    private func getUrl(_ address: String) -> String {
        return String(format: "%@/%@", url, address)
    }
    
    // MARK: - getData
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
    
    // MARK: - onLoggin
    public func onLoggin(_ email: String, pass: String, logginResult: @escaping LogginResult) {
        let parameters = ["login": email, "password": pass, "device_token": "-", "fsm_token": "-"]
        httpConnection.execute(getUrl("auth/login/"), parameters: parameters, method: "POST") { [self] result, error in
            if error == nil {
                let data = result as! [String: Any]
                let model = AuthModel(root: data["root"] as! Bool, sid: data["sid"] as! String, error: data["error"] as! String, mqtt: data["mqtt"] as! Bool)
                auth.update(model: model)
            }
            logginResult(error)
        }
    }
    
    // MARK: - Finanse
    private func getFinanse() {
        httpConnection.execute(getUrl("finanse/"), parameters: ["sid": auth.sid], method: "GET") { data, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setFinanse(data: data)
                self.onNext(self.model)
                self.log("getFinanse()", error)
            }
        }
    }
 
    // MARK: - Jurnal
    private func getJurnal() {
        httpConnection.execute(getUrl("jurnal/"), parameters: ["sid": auth.sid], method: "GET") { data, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setJurnal(data: data)
                self.onNext(self.model)
                self.log("getJurnal()", error)
            }
        }
    }
    
    // MARK: - File
    private func getFile() {
        httpConnection.execute(getUrl("file/"), parameters: ["sid": auth.sid], method: "GET") { data, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setFile(data: data)
                self.onNext(self.model)
                self.log("getFile()", error)
            }
        }
    }
    
    // MARK: - Profile
    private func getProfile() {
        httpConnection.execute(getUrl("profile/"), parameters: ["sid": auth.sid], method: "GET") { data, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setProfile(data: data)
                self.onNext(self.model)
                self.log("getProfile()", error)
            }
        }
    }
    
    // MARK: - Num
    private func getNum() {
        httpConnection.execute(getUrl("num/"), parameters: ["sid": auth.sid], method: "GET") { data, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setNum(data: data)
                self.onNext(self.model)
                self.log("getNum()", error)
            }
        }
    }
    
    // MARK: - Acc
    private func getAcc() {
        httpConnection.execute(getUrl("acc/"), parameters: ["sid": auth.sid], method: "GET") { data, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setAcc(data: data)
                self.onNext(self.model)
                self.log("getAcc()", error)
            }
        }
    }
    
    // MARK: - Obj
    private func getObj() {
        httpConnection.execute(getUrl("obj/"), parameters: ["sid": auth.sid], method: "GET") { data, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setObj(data: data)
                self.onNext(self.model)
                self.log("getObj()", error)
            }
        }
    }
    
    // MARK: - Users
    private func getUsers() {
        let address = String(format: "%@/staff/", url)
        httpConnection.execute(address, parameters: ["sid": auth.sid], method: "GET") { data, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.rxData.onError(error!)
                    return
                }
                self.model.setUsers(data: data)
                self.onNext(self.model)
                self.log("getUsers()", error)
            }
        }
    }
}
