//
//  Network.swift
//  bc
//
//  Created by Evgeny Hailov on 30.06.2023.
//

import Foundation
import Alamofire

public typealias HttpConnectionResult = (Any?, NSError?) -> Void

public class EHHttpConnection {
    
    public func execute(_ address: String, parameters: [String: String]?, method: String, result: @escaping HttpConnectionResult) {
        var af: DataRequest
        if method == "GET" {
            let address = String(format: "%@%@", address, getStringParameters(parameters))
            af = AF.request(address, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getHTTPHeaders())
        } else if method == "POST" {
            af = AF.request(address, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: getHTTPHeaders())
        } else {
            return
        }
        af.validate(contentType: ["text/html", "application/json", "application/octet-stream"])
        af.response { [self] data in
            if data.error != nil {
                result(nil, getError(data.error!.errorDescription, code: 1))
                return
            }
            let statusCode = data.response?.statusCode
            if statusCode == 200 {
                result(parceJson(data.data!), nil)
            } else if statusCode == 403 {
                result(nil, getError("session expired", code: 3))
            } else {
                result(nil, getError("cloud error", code: 1))
            }
        }
    }
    
    private func getError(_ errorDescription: String?, code: Int) -> NSError {
        if errorDescription == nil {
            let userInfo = [NSLocalizedDescriptionKey: "unknown error"]
            return NSError(domain: "BC_Error", code: code, userInfo: userInfo)
        }
        let userInfo = [NSLocalizedDescriptionKey: errorDescription!]
        return NSError(domain: "BC_Error", code: code, userInfo: userInfo)
    }
    
    private func getStringParameters(_ parameters: [String: Any]?) -> String {
        var requestString = ""
        if parameters != nil {
            for (key, value) in parameters! {
                requestString = requestString.appending(String(format: "?%@=%@&", key, value as? String ?? "-"))
            }
        }
        return requestString
    }
    
    private func getHTTPHeaders() -> HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(HTTPHeader(name: "Content-Type", value: "application/x-www-form-urlencoded"))
        return headers
    }
    
    func parceJson(_ data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data)
        } catch {
            EHLogger.verbose("Model is error", error: (error) as NSError)
            return nil
        }
    }
    
    private func getDataFor(url: URL) -> Data? {
        var data: Data? = nil
        do {
            data = try Data(contentsOf: url)
        } catch {
            EHLogger.verbose("-", error: (error) as NSError)
        }
        return data
    }
    
}

//MARK: - Upload data
extension EHHttpConnection {
    
    public func upload(_ address: String, parameters: [String: Any], result: @escaping HttpConnectionResult) {
        let af = AF.upload(multipartFormData: {
            for parameter in parameters {
                let type = type(of: parameter.value)
                if type == Data.self {
                    let name = parameter.key
                    $0.append(parameter.value as! Data, withName: name, fileName: "image.png", mimeType: "text/plain")
                } else if type == URL.self {
                    $0.append(parameter.value as! URL, withName: parameter.key)
                } else if type == String.self {
                    let data = parameter.value as! String
                    $0.append(data.data(using: .utf8)!, withName: parameter.key)
                } else {
                    continue
                }
                
            }
            
        }, to: address, method: .post, headers: getHTTPHeaders())
        
        af.response { [self] data in
            if data.error != nil {
                result(nil, getError(data.error!.errorDescription, code: 1))
                return
            }
            let statusCode = data.response?.statusCode
            if statusCode == 200 {
                result(parceJson(data.data!), nil)
            } else {
                result(nil, getError("statusCode != 200", code: 1))
            }
        }
    }
}
